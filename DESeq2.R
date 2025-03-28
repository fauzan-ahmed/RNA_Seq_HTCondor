# Load required libraries
library(Rsubread)    # for featureCounts
library(DESeq2)      # for differential expression analysis
library(ggplot2)     # for visualization (PCA & volcano plots)
library(pheatmap)    # for heatmaps

# Get the count matrix
counts <- fc$counts

# Create sample names by stripping the path and file extension from the BAM file names.
sample_names <- sapply(basename(bam_files), function(x) sub("\\.bam$", "", x))
colnames(counts) <- sample_names

# Create DESeq2 dataset and pre-filter low-count genes
dds <- DESeqDataSetFromMatrix(countData = counts,
                              colData = sample_info,
                              design = ~ condition)
dds <- dds[rowSums(counts(dds)) > 1, ]

# Run the DESeq2 analysis pipeline
# Change the conditions according to your experiement; for ex treated vs untrearted, allergic vs non allergic
dds <- DESeq(dds)
res <- results(dds, contrast = c("condition", "control", "disease"))
resOrdered <- res[order(res$padj), ]
write.csv(as.data.frame(resOrdered), file = "deseq2_results.csv")

rld <- rlog(dds, blind=FALSE)
pcaData <- plotPCA(rld, intgroup="condition", returnData=TRUE)
percentVar <- round(100 * attr(pcaData, "percentVar"))
p_pca <- ggplot(pcaData, aes(PC1, PC2, color=condition)) +
  geom_point(size=3) +
  xlab(paste0("PC1: ", percentVar[1], "% variance")) +
  ylab(paste0("PC2: ", percentVar[2], "% variance")) +
  ggtitle("PCA Plot")
ggsave(filename = file.path(plots_dir, "PCA_plot.png"), plot = p_pca, width = 6, height = 4)
cat("PCA plot saved to", file.path(plots_dir, "PCA_plot.png"), "\n")

## MA Plot
png(filename = file.path(plots_dir, "MA_plot.png"), width = 600, height = 400)
plotMA(res, main="DESeq2 MA Plot", ylim=c(-5,5))
dev.off()
cat("MA plot saved to", file.path(plots_dir, "MA_plot.png"), "\n")

##  Volcano Plot
volcanoData <- as.data.frame(res)
volcanoData$gene <- rownames(volcanoData)
# Mark genes with padj < 0.05 and |log2FoldChange| > 1 as significant
volcanoData$significant <- ifelse(volcanoData$padj < 0.05 & abs(volcanoData$log2FoldChange) > 1, "yes", "no")
p_volcano <- ggplot(volcanoData, aes(x = log2FoldChange, y = -log10(padj), color = significant)) +
  geom_point(alpha = 0.5) +
  theme_minimal() +
  ggtitle("Volcano Plot") +
  xlab("Log2 Fold Change") +
  ylab("-Log10 Adjusted P-value") +
  scale_color_manual(values = c("no" = "grey", "yes" = "red"))
ggsave(filename = file.path(plots_dir, "volcano_plot.png"), plot = p_volcano, width = 6, height = 4)
cat("Volcano plot saved to", file.path(plots_dir, "volcano_plot.png"), "\n")

## Heatmap of Top 20 Differentially Expressed Genes
# Select top 20 genes based on adjusted p-value
topGenes <- head(rownames(resOrdered), 20)
mat <- assay(rld)[topGenes, ]
mat <- mat - rowMeans(mat)
# pheatmap automatically plots to the current device; we'll save it as PNG.
png(filename = file.path(plots_dir, "heatmap_top20.png"), width = 600, height = 600)
pheatmap(mat, cluster_rows = TRUE, cluster_cols = TRUE, annotation_col = sample_info,
         main = "Top 20 Differentially Expressed Genes")
dev.off()
cat("Heatmap saved to", file.path(plots_dir, "heatmap_top20.png"), "\n")

cat("All analyses and visualizations have been completed!\n")
