#!/bin/bash
# Perform MultiQC after fastp trimming to evaluate reads quality. 
# Not necessary to implement
cp /..../*.json .
cp /..../*.trimmed_fastqc.zip .
multiqc -n trimmed.html .
cp trimmed.html /...../
