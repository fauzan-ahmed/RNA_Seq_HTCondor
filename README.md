# RNA Seq HTCondor
This repository consists of implementation of standard RNA-seq processing which can be implemented on HTCondor. It consists of submit files, and scripts required to implement the workflow. 

# Environment 
Definition files required for building Singularity files are also included. One SIF file consisting of required modules is built here. 

Run `ls *.fastq.gz | cut -d'_' -f1 | sort | uniq > samples.txt` in the command line, preferably in the directory where the fastq files are stored to generalize scripts. 



