# Scripts_Bioinformatica

Bioinformatics QC Pipeline — FASTQ → FastQC → Trimmomatic → MultiQC

This repository contains a modular sequencing-quality pipeline for Illumina FASTQ data.
It includes automated directory creation, integrity checks (MD5), filename normalization,
FastQC, Trimmomatic trimming, and MultiQC summary generation.

## Requirements

bash >= 4
FastQC
Trimmomatic
MultiQC


## Usage examples 

bash scripts/create_directories.sh
bash scripts/run_checksum_and_rename.sh
bash scripts/run_fastqc_raw.sh
bash scripts/run_trimmomatic.sh
bash scripts/run_multiqc.sh

## Directory Structure

```text
Project/
├── Scripts/
│   ├── create_directories.sh
│   ├── run_checksum_and_rename.sh
│   ├── run_fastqc_raw.sh
│   ├── run_trimmomatic.sh
│   └── run_multiqc.sh
│  
│
├── Data/
│   └── Raw_data/
│
├── Tools/
│   ├── Fastqc/
│   ├── Fastqc_trimmed/
│   ├── Trimmed_data/
│   └── Multiqc_report/
│
└── logs/
```



## Workflow Diagram

Raw FASTQ
   ↓ (MD5 + rename)
QC1: FastQC (raw)
   ↓
Trimmomatic
   ↓
QC2: FastQC (trimmed)
   ↓
MultiQC Summary





Author: Nathalia Crespo

ULisboa — Introduction to Bioinformatics and Computational Biology
