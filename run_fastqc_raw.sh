#!/bin/bash

# This script runs FastQC on all raw FASTQ files in the project. It 
# automatically detects every .fastq.gz file in the raw data directory and 
# performs quality control for each sample. 
#
# All FastQC reports are saved into the Fastqc/ directory, and a log file is 
# generated for reproducibility. Output is shown live and saved via 'tee'.

#Exit on error
set -euo pipefail


# Directory variables 
PROJECT_DIR="./Project"
RAW_DATA_DIR="$PROJECT_DIR/Data/Raw_data"
FASTQC_RAW_DIR="$PROJECT_DIR/Tools/Fastqc"
LOG_DIR="$PROJECT_DIR/logs"

# Log file name with date + time
LOG_FILE="$LOG_DIR/fastqc_raw_$(date +%Y%m%d_%H%M%S).log"


# Create output and log directories if they don't exist 
mkdir -p "$LOG_DIR" 
mkdir -p "$FASTQC_RAW_DIR" 
mkdir -p "$RAW_DATA_DIR"
touch "$LOG_FILE"


# Redirect all standard output (1) and errors (2) to the log file and show at the terminal
exec > >(tee -a "$LOG_FILE") 2>&1 

echo "========================================================="
echo "         🥩🥩  FASTQC for RAW FASTQ files 🥩🥩"
echo "========================================================="
echo "Log file: $LOG_FILE"
echo "Raw data directory: $RAW_DATA_DIR"
echo "---------------------------------------------------------" 


# Search for all FASTQ.gz files and run FastQC one by one (for any number of samples)
#Search in RAW_DATA_DIR for files ending in .fastq.gz, limiting to that directory only (no subdirs)
#Filter files that ends with .fastq.gz
# output result of the first part to while loop that reads each file line by line
find "$RAW_DATA_DIR" -maxdepth 1 -name "*.fastq.gz" | while read FASTQ_FILE; do

    FILE_NAME=$(basename "$FASTQ_FILE")

    echo ""
    echo ">>> Processing sample: $FILE_NAME"

    # Run FastQC
    fastqc "$FASTQ_FILE" -o "$FASTQC_RAW_DIR"

    echo "✓ FastQC completed for $FILE_NAME"
done


echo "-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-."
echo "         FASTQC successfully finished     🍜🍜🍜🍜    "
echo "Results available at: $FASTQC_RAW_DIR"
echo "Log saved at: $LOG_FILE"
echo "-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-."

RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${RED}"
echo "      _  _ "
echo "     ( \/ )"
echo "      \  /"
echo "       \/"
echo -e "${NC}"