#!/bin/bash
set -e
# The sample identifier (base name); e.g. "s0001-0_S532_L004"
SAMPLE="$1"

# Define input, output, and reference directories
INPUT_DIR="..../reads"
OUTPUT_DIR="..../reads/"
GENOME_DIR="..../reference"
cp "${INPUT_DIR}/${SAMPLE}_R1.trimmed.fastq.gz" .
cp "${INPUT_DIR}/${SAMPLE}_R2.trimmed.fastq.gz" .

# The parameters below are default parameters. Refer to https://github.com/alexdobin/STAR for detailed overview. 

STAR --runThreadN 16 \
     --genomeDir "$GENOME_DIR" \
     --readFilesIn "${SAMPLE}_R1.trimmed.fastq.gz" "${SAMPLE}_R2.trimmed.fastq.gz" \
     --readFilesCommand zcat \
     --outFileNamePrefix "${SAMPLE}_" \
     --outSAMtype BAM SortedByCoordinate \
     --outFilterScoreMinOverLread 0.66 \
     --outFilterMatchNminOverLread 0.66

echo "Zipping and cleaning up files before transfer"
tar -czf "${SAMPLE}_STAR_output.tar.gz" ${SAMPLE}_*
mv "${SAMPLE}_STAR_output.tar.gz" "${INPUT_DIR}/"
rm "${SAMPLE}_R1.trimmed.fastq.gz" "${SAMPLE}_R2.trimmed.fastq.gz"
rm -rf ${SAMPLE}_*
echo "Analysis Completed"
