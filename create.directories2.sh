#!/bin/bash


PROJECT_NAME="Project_ibbc_nathalia"

#  Create the main directory and all subdirectories WITHIN it with a single command.
mkdir -p "$PROJECT_NAME"/{Scripts,Raw_data,Fastqc_raw,Trimmed_data,Fastqc_trimmed,Multiqc_report,Alignment,Downstream_analysis}

echo "🎉 Successfully created project structure in.: $PROJECT_NAME/"