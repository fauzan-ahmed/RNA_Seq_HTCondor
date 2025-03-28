# If your gene IDs are already in ENTREZ format or another type, adjust the fromType accordingly.
gene.df <- bitr(sigGenes, fromType = "ENSEMBL", toType = "ENTREZID", OrgDb = org.Hs.eg.db)

# Perform GO enrichment analysis for Biological Processes (BP)
ego_bp <- enrichGO(gene = gene.df$ENTREZID,
                   OrgDb = org.Hs.eg.db,
                   ont = "BP",
                   pAdjustMethod = "BH",
                   pvalueCutoff = 0.05,
                   qvalueCutoff = 0.05,
                   readable = TRUE)

# Display a summary of the enriched GO terms
print(head(ego_bp))

# Create a directory for plots if it doesn't exist
plots_dir <- "plots"
if (!dir.exists(plots_dir)) {
  dir.create(plots_dir)
}

Barplot of Enriched GO Terms
barplot_ego <- barplot(ego_bp, showCategory = 20, title = "GO BP Enrichment")
ggsave(filename = file.path(plots_dir, "GO_BP_barplot.png"),
       plot = barplot_ego, width = 8, height = 6)
cat("Barplot saved to", file.path(plots_dir, "GO_BP_barplot.png"), "\n")

# 5.2 Dotplot of Enriched GO Terms
dotplot_ego <- dotplot(ego_bp, showCategory = 20, title = "GO BP Enrichment")
ggsave(filename = file.path(plots_dir, "GO_BP_dotplot.png"),
       plot = dotplot_ego, width = 8, height = 6)
cat("Dotplot saved to", file.path(plots_dir, "GO_BP_dotplot.png"), "\n")

cat("Overrepresentation analysis completed!\n")
