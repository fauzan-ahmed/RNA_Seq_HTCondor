#!/bin/bash
set -e

# Although SAMPLE is defined, it's not used in this script.
# If you want to process a specific sample, you could adjust the cp and featureCounts arguments.


# Define the input directory (staging area) and output directory.
INPUT_DIR="/....."

# Define where you want the final results to be stored.
OUTPUT_DIR="/...../"

echo "Copying BAM files from ${INPUT_DIR} to working node..."
# Fix: Specify the destination directory (WORK_DIR) for the copied BAM files.
cp "${INPUT_DIR}"/*_Aligned.sortedByCoord.out.bam .

echo "Running featureCounts..."
Rscript featcounts.R

rm *.bam
mv *.txt ${OUTPUT_DIR}
