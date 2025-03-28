# RNA Seq HTCondor
This repository consists of implementation of standard RNA-seq processing which can be implemented on HTCondor. It consists of submit files, and scripts required to implement the workflow. 

# Environment 
Definition files required for building Singularity files are also included. One SIF file consisting of required modules is built here. 

Run `ls *.fastq.gz | cut -d'_' -f1 | sort | uniq > samples.txt` in the command line, preferably in the directory where the fastq files are stored to generalize scripts. 


# Implementation

<img width="1065" alt="Screenshot 2025-03-27 at 9 30 00 PM" src="https://github.com/user-attachments/assets/a29ffa1a-5b85-45c1-9eb8-0048e708e24c" />

The order of implementation of all the scripts

`concatenate.sub -> fastp.sub -> multiqc.sub -> fastp.sub (optional) -> reference_build.sub (if reference genome does not exist) -> star.sub -> featureCounts.sub -> DESeq2.sub`

You can refer to https://chtc.cs.wisc.edu/uw-research-computing/htcondor-quick-ref for basic commands for HTCondor. 
