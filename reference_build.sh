#!/bin/bash
set -e

cp /..../Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa .
cp /..../Homo_sapiens.GRCh38.113.gtf .

#gunzip Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa.gz
#gunzip Homo_sapiens.GRCh38.113.gtf.gz

mkdir reference
THREADS="${_CONDOR_NCPUS:-1}"
# --sjdbOverhang should be number of (b.p in reads - 1) 
# Default is 100

STAR --runMode genomeGenerate --genomeDir reference/ --genomeFastaFiles Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa --sjdbGTFfile Homo_sapiens.GRCh38.113.gtf --runThreadN "${THREADS}" --sjdbOverhang 150

mv reference ..../
rm Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa
rm Homo_sapiens.GRCh38.113.gtf
