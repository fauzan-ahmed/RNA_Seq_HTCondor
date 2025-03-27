# Load the Rsubread package
library(Rsubread)

# Define the directory containing your BAM files
bam_dir <-   # Replace with your BAM file directory
bam_files <- list.files(pattern = "\\.bam$", full.names = TRUE)

# Specify the path to your annotation file (GTF/GFF)
annotation_file <- "Homo_sapiens.GRCh38.113.gtf"  # Replace with your annotation file

# Run featureCounts to quantify gene counts
# The parameters below assume you want to count reads mapping to exons
fc_results <- featureCounts(files = bam_files,
                            annot.ext = annotation_file,
                            isGTFAnnotationFile = TRUE,
                            GTF.featureType = "exon",
                            GTF.attrType = "gene_id",
                            nthreads = 12)

# Write the raw counts to a file for later use
write.table(fc_results$counts,
            file = "gene_counts.txt",
            sep = "\t",
            quote = FALSE)
