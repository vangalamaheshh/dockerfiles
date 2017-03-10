#library("BiocParallel")
library("DESeq2")
library("ggplot2")
library("ggrepel")
library("dplyr")

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
  results <- cbind(ID = rownames(res), as.matrix(res))
  write.table(results, paste(comp, "/", comp, ".deseq2.csv", sep = ""), sep = ',', 
              col.names = TRUE, row.names = FALSE, quote = FALSE)
  res$Gene <- rownames(res)
  res <- na.omit(res)
  rownames(res) <- NULL
  res <- mutate(as.data.frame(res), sig = ifelse(res$padj < 0.05, 'FDR < 0.05', "Not Significant"))
  png(paste(comp, "/", comp, ".volcano.png", sep = ""), width = 8, height = 8, unit="in",res=300 )
  volcano_plot <- ggplot(res, aes(log2FoldChange, -log10(pvalue))) +
    geom_point(aes(col = sig)) +
    scale_color_manual(values = c("red", "black"))
  volcano_plot <- volcano_plot + geom_text_repel(data = filter(res, padj < 0.05), aes(label = Gene))
  volcano_plot
  dev.off()
}

