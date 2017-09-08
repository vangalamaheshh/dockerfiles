#!/bin/bash

# ENV variables required
CLOUDSDK_CORE_PROJECT="synergist-170903"

# activate account
gcloud auth activate-service-account --key-file=${gmx_file} 

# if sample_name dataset exists - delete it
for dataset_id in $(gcloud alpha genomics datasets list | grep ${sample_name} | grep -oP "^\S+"); do
  echo Y | gcloud alpha genomics datasets delete ${dataset_id}
done

# create dataset
dataset_id=$(gcloud alpha genomics datasets create --name=${sample_name} 2>&1 | grep -oP "id:\s+(\d+)" | sed -e "s/id:\s*//g")

# create variantset
variantset_id=$(gcloud alpha genomics variantsets create --dataset-id=${dataset_id} --name=${sample_name} 2>&1 | grep -oP "id: \d+" | head -1 | sed -e "s/id:\s*//g")

# import variants
var_op_id=$(gcloud alpha genomics variants import --variantset-id=${variantset_id} --source-uris "${vcf_file}" 2>&1 | grep -oP "name:\s+(.+)" | sed -e "s/name:\s*//g")

# create bq dataset if not exists
bq_exists=$(bq ls | grep "${project_id}")

# if project id - bq dataset does not exist; create it
if [ -z $bq_exists ]; then
  bq mk ${project_id}
fi

table_name=${sample_name}

# keep checking until variant operation completes
while [ $(gcloud alpha genomics operations describe "${var_op_id}"  | grep "done:" | sed -e "s/done:\s*//g") == "false" ]; do 
  sleep 600; #sleep for 10min 
done

# export variants to bq table
bq_op_id=$(gcloud alpha genomics variantsets export ${variantset_id} ${table_name} --bigquery-dataset ${project_id} 2>&1 | grep -oP "name:\s+(.+)" | sed -e "s/name:\s*//g")

# keep checking until bq operation completes
while [ $(gcloud alpha genomics operations describe "${bq_op_id}"  | grep "done:" | sed -e "s/done:\s*//g") == "false" ]; do                  sleep 600; #sleep for 10min 
done

# clean up of genomics dataset 
for dataset_id in $(gcloud alpha genomics datasets list | grep ${sample_name} | grep -oP "^\S+"); do
  echo Y | gcloud alpha genomics datasets delete ${dataset_id}
done

# Finally create output file
touch "${out_file}"

