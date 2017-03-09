#library("BiocParallel")
library("DESeq2")

#register(MulticoreParam(6))

meta <- read.csv("metasheet.csv", header = TRUE, row.names = 1, sep = ",")
counts <- read.csv("STAR.csv", header = TRUE, row.names = 1, sep = ",")

meta <- meta[, grepl("comp_*", colnames(meta)), drop = FALSE]

for (comp in colnames(meta)) {
  paste("Processing", comp, sep = " ")
  ctrl <- rownames(meta[meta[, comp] == 1, comp, drop = FALSE])
  treat <- rownames(meta[meta[, comp] == 2, comp, drop = FALSE])
  count_data <- counts[,c(treat, ctrl)]
  condition <- c(rep("treat", length(treat)), rep("ctrl", length(ctrl)))
  col_data <- as.data.frame(cbind(colnames(count_data), condition))
  dds <- DESeqDataSetFromMatrix(countData = count_data, colData = col_data, design = ~ condition)
  dds <- dds[rowSums(counts(dds)) > 0, ]
  dds <- DESeq(dds, parallel = FALSE)
  res <- results(dds, parallel = FALSE)
  res <- res[order(as.numeric(res[,"padj"])), ]
  res <- cbind(ID = rownames(res), as.matrix(res))
  write.table(res, paste(comp, "/", comp, ".deseq2.csv", sep = ""), sep = ',', 
    col.names = TRUE, row.names = FALSE, quote = F)
}

