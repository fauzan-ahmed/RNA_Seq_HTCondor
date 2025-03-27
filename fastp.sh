#!/bin/bash
set -e 

# Define the input and output directories
INPUT_DIR="..../reads"
OUTPUT_DIR="..../reads"

# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# The sample identifier (base name)
SAMPLE="$1"

# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Build full file paths for the paired-end reads
R1="${INPUT_DIR}/${SAMPLE}_R1.fastq.gz"
R2="${INPUT_DIR}/${SAMPLE}_R2.fastq.gz"

# Define the output filenames
OUT_R1="${OUTPUT_DIR}/${SAMPLE}.R1.trimmed.fastq.gz"
OUT_R2="${OUTPUT_DIR}/${SAMPLE}.R2.trimmed.fastq.gz"

echo "Processing sample: $SAMPLE"
echo "Input R1: $R1"
echo "Input R2: $R2"
echo "Output R1: $OUT_R1"
echo "Output R2: $OUT_R2"


# Refer to https://github.com/OpenGene/fastp for detailed information on trimming. 
# Default parameters work well with most files.
fastp \
    -i "$R1" \
    -I "$R2" \
    -o "$OUT_R1" \
    -O "$OUT_R2" \
    -q 33 \
    --detect_adapter_for_pe \
    --cut_front_window_size 4 \
    --cut_front_mean_quality 15 \
    -3 \
    --cut_tail_window_size 4 \
    --cut_tail_mean_quality 15 \
    -l 36 \
    -j "${OUTPUT_DIR}/${SAMPLE}.json" \
    -h "${OUTPUT_DIR}/${SAMPLE}.html" 

