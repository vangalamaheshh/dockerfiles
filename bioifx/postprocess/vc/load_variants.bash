#!/bin/bash
set -o pipefail
# ENV variables required
CLOUDSDK_CORE_PROJECT="synergist-170903"
BQ_GENOMICS_DATASET="genomics_api"

# activate account
gcloud auth activate-service-account --key-file=${gmx_file} 

# if sample_name dataset exists - delete it
for dataset_id in $(gcloud alpha genomics datasets list | grep ${project_id} | cut -f 1 -d " "); do
  echo Y | gcloud alpha genomics datasets delete ${dataset_id}
done

# create dataset
dataset_id=$(gcloud alpha genomics datasets create --name=${project_id} 2>&1 | grep -o "id:\s*\d*" | sed -e "s/id: //g")

# create variantset
variantset_id=$(gcloud alpha genomics variantsets create --dataset-id=${dataset_id} --name=${project_id} 2>&1 | grep -o "id:\s*\d*" | head -1 | sed -e "s/id: //g")

# import variants
# first, make sure you have comma separated vcf file list
vcf_file_list=$(echo "${vcf_file_list}" | tr "\n" "," | tr " " "," | sed -e "s/,$//")
echo "vcf_file_list: ${vcf_file_list}" >&2

var_op_id=$(gcloud alpha genomics variants import --variantset-id=${variantset_id} --source-uris=${vcf_file_list} 2>&1 | grep "name:" | sed -e "s/name: //g")

# create bq dataset if not exists
bq_exists=$(bq ls | grep "${BQ_GENOMICS_DATASET}")

# if bq dataset does not exist; create it
if [ -z $bq_exists ]; then
  bq mk "${BQ_GENOMICS_DATASET}"
fi

table_name="${project_id}"

# if table exists - drop it
table_exists=$(bq ls "${BQ_GENOMICS_DATASET}" | grep "${table_name}" )

if [ ! -z $table_exists ]; then
  bq rm -t -f "${BQ_GENOMICS_DATASET}.${table_name}"
fi

# keep checking until variant operation completes
while [ $(gcloud alpha genomics operations describe "${var_op_id}"  | grep "done:" | sed -e "s/done: *//g") == "false" ]; do 
  sleep 600; #sleep for 10min 
done

# export variants to bq table
bq_op_id=$(gcloud alpha genomics variantsets export ${variantset_id} ${table_name} --bigquery-dataset ${BQ_GENOMICS_DATASET} 2>&1 | grep -o "name:" | sed -e "s/name: //g")

# keep checking until bq operation completes
while [ $(gcloud alpha genomics operations describe "${bq_op_id}"  | grep "done:" | sed -e "s/done: //g") == "false" ]; do
  sleep 600; #sleep for 10min 
done

# clean up of genomics dataset 
for dataset_id in $(gcloud alpha genomics datasets list | grep ${project_id} | cut -f 1 -d " "); do
  echo Y | gcloud alpha genomics datasets delete ${dataset_id}
done

# Finally create output file
touch "${out_file}"

