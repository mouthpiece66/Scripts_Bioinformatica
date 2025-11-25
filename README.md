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
│
├── Data/Raw_data/
│
├── Tools/
│   ├── Fastqc/
│   ├── Fastqc_trimmed/
│   ├── Trimmed_data/
│   ├── Multiqc_report/
│   ├── Checksums/
│   └── Scripts/
│
├── Downstream_analysis/
│   └── Alignment/
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





✔ Filename normalization (R1/R2)

✔ One MD5 per sample

✔ Supports .fastq.gz, .fq.gz, .sam, .bam

✔ Logging to terminal + file (tee)

✔ Designed for any number of samples

✔ HPC-friendly, reproducible, modular



Author: Nathalia Crespo

ULisboa — Introduction to Bioinformatics and Computational Biology
