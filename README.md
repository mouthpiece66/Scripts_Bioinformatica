# Scripts_Bioinformatica

### Bioinformatics QC Pipeline — FASTQ → FastQC → Trimmomatic → MultiQC



This repository contains a modular and reproducible quality-control pipeline for Illumina FASTQ sequencing data.  
The workflow includes:

- Automated directory creation  
- Filename normalization (R1/R2 standardization)  
- Per-file MD5 integrity checks  
- Raw FastQC  
- Trimmomatic paired-end trimming  
- Post-trim FastQC  
- MultiQC summary generation  

All scripts are implemented in Bash and are designed to scale to any number of samples.

##  Requirements (must be installed before running the pipeline)

Make sure the following tools are already installed on your system:

- **bash ≥ 4**
- **FastQC**
- **Trimmomatic**
- **MultiQC**
- (optional) Java ≥ 8 for Trimmomatic if not already available

The scripts assume a Linux environment.


## 🧪 Supported Sample Filename Formats (automatic correction)

The pipeline automatically standardizes many common FASTQ naming patterns:

✔ Illumina lane patterns  
- `*_R1_001.fastq.gz` → `*_R1.fastq.gz`  
- `*_R2_002.fastq.gz` → `*_R2.fastq.gz`

✔ Simple patterns  
- `*_1.fastq.gz` → `*_R1.fastq.gz`  
- `*_2.fq.gz` → `*_R2.fq.gz`

✔ Complex patterns  
- `*_1_*anything*.fastq.gz` → `*_R1.fastq.gz`  
- `*_2_*anything*.fastq.gz` → `*_R2.fastq.gz`

This ensures that all samples follow the required format:

- sampleName_R1.fastq.gz 

- sampleName_R2.fastq.gz

This naming consistency is essential for FastQC, Trimmomatic, and MultiQC.


## 🚀 Pipeline Execution Steps (IMPORTANT)

All the scripts should be run from the root `Project/` directory.
The order of execution is as follows:

## 1) Create the project directory structure:

bash create_directories.sh

This generates the directory structure under `Project/`.

## 2) MOVE YOUR RAW FASTQ SAMPLES (IMPORTANT)

After creating the directory structure, move your raw FASTQ files into:
`Project/Data/Raw_data/`

## 3) Run the checksum and rename script:

bash run_checksum_and_rename.sh

This script will:
- Normalize filenames to the required format.
- Generate one MD5 checksum per file for integrity verification.
- Saves each checksum as `<filename>.md5` in `Project/Tools/Checksums/`.
- Logs all actions to a timestamped log file in `Project/logs/`.

## 4) Run FastQC on raw data:

bash run_fastqc.sh

This performs quality control on the raw FASTQ in `Project/Data/Raw_data` files and saves results in `Project/Tools/Fastqc/`.

## 5) Run Trimmomatic for quality trimming:

bash run_trimmomatic.sh

This trims adapters and low-quality bases from the FASTQ files, saving trimmed outputs in `Project/Tools/Trimmed_data/`.

## 6) Run MultiQC on trimmed data:

bash run_multiqc.sh

This aggregates FastQC reports from trimmed data and generates a summary report in `Project/Tools/Multiqc_report/`.

All the steps above generate log files in `Project/logs/` for transparency and reproducibility.



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

```text
Raw FASTQ
   ↓ (MD5 + rename)   
QC1: FastQC (raw)
   ↓
Trimmomatic
   ↓
QC2: FastQC (trimmed)
   ↓
MultiQC Summary
```




✔ Filename normalization (R1/R2)

✔ One MD5 per sample

✔ Supports .fastq.gz, .fq.gz, .sam, .bam

✔ Logging to terminal + file (tee)

✔ Designed for any number of samples

✔ HPC-friendly, reproducible, modular



Author: Nathalia Crespo

ULisboa — Introduction to Bioinformatics and Computational Biology
