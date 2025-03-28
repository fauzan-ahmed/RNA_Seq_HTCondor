# RNA-Seq Workflow Implementation in HTCondor
This repository consists of implementation of a basic RNA-seq data processing to identify Differentially Expressed Genes and perform pathway analysis on HTCondor. It consists of submit files, and scripts required to implement the workflow and the defintion file to install the necessary softwares. 

# Author
Fauzan Ahmed @ fauzan-ahmed

# Environment 
Definition files required for building Singularity files are also included. One SIF file consisting of required modules is built here. 

Prior to implementation, modules needed for analysis need to be installed. Docker images can be pulled from dockerhub by specifying in `container_image = <docker image>`.

Apptainer definition file in rna_seq.def pulls all the required packages/tools from miniconda. To build image `condor_submit rna_seq.def`. In build job, build container through `apptainer build <container name> rna_seq.def`.

Run `ls *.fastq.gz | cut -d'_' -f1 | sort | uniq > samples.txt` in the command line to obtain sample which can be used for generalizing scripts to take full advantage of parallel computing. 


# Implementation

<img width="1065" alt="Screenshot 2025-03-27 at 9 30 00 PM" src="https://github.com/user-attachments/assets/a29ffa1a-5b85-45c1-9eb8-0048e708e24c" />

The order of implementation of all the scripts

`concatenate.sub -> fastp.sub -> multiqc.sub -> fastp.sub (optional) -> reference_build.sub (if reference genome does not exist) -> star.sub -> featureCounts.sub -> DESeq2.sub`

DESeq2 and Over-represenation analysis can be conducted locally on RStudio if preferred. Furthermore, https://www.gsea-msigdb.org/gsea/msigdb, https://geneontology.org can also be used for pathway analysis. 


You can refer to https://chtc.cs.wisc.edu/uw-research-computing/htcondor-quick-ref for more detailed instructions. 
