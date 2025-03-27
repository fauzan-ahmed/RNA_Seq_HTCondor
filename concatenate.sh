#!/bin/bash
set -e
# This is an optional script to merge reads from the same sample from multiple lanes into single a single fastq file.


SAMPLE="$1"
cp /..../${SAMPLE}_S5*_L00{4,5}_R1_001.fastq.gz .
cp /..../${SAMPLE}_S5*_L00{4,5}_R2_001.fastq.gz .

cat ${SAMPLE}_S5*_L00{4,5}_R1_001.fastq.gz > ${SAMPLE}_R1.fastq.gz
cat ${SAMPLE}_S5*_L00{4,5}_R2_001.fastq.gz > ${SAMPLE}_R2.fastq.gz

# Tarball the files and transfer them to staging directory
tar -cvf ${SAMPLE}.tar.gz ${SAMPLE}_R1.fastq.gz ${SAMPLE}_R2.fastq.gz 
mv ${SAMPLE}.tar.gz /..../reads/
rm -rf *.fastq.gz 
