#!/bin/bash

# This script runs Trimmomatic on all paired-end FASTQ files in a directory.

set -euo pipefail # Exit on error


# 2. Full path to the adapter sequences file
ADAPTERS_FILE="/home/fc66501/miniconda3/envs/tools_qc/share/trimmomatic-0.40-0/adapters/TruSeq3-PE-2.fa"


# Directory variables 
RAW_DATA_DIR="./Project/Data/Raw_data"
TRIMMED_DATA_DIR="./Project/Tools/Trimmed_data"
LOG_DIR="./Project/logs"
LOG_FILE="${LOG_DIR}/trimmomatic_$(date +%Y%m%d_%H%M%S).log"

# Create output and log directories if they don't exist 
mkdir -p "$TRIMMED_DATA_DIR"
mkdir -p "$LOG_DIR"
touch "$LOG_FILE"

# Redirect all output to a log file and show in the terminal
exec > >(tee -a "$LOG_FILE") 2>&1

echo "========================================================="
echo " ✂️✂️ STARTING: Trimmomatic Paired-End Processing  ✂️✂️"
echo "========================================================="
echo "Log file: $LOG_FILE"
echo "Raw FASTQ directory: $RAW_DATA_DIR"
echo "Trimmed output directory: $TRIMMED_DATA_DIR"
echo "---------------------------------------------------------"


if [ ! -f "$ADAPTERS_FILE" ]; then
    echo "Error: Adapters file not found at '$ADAPTERS_FILE'"
    echo "Please edit the script and set the correct path."
    exit 1
fi

# Loop through all forward read files (_R1)
for R1_FILE in "$RAW_DATA_DIR"/*_R1.fastq.gz; do
    
    # Get the base name of the sample
    BASENAME=$(basename "$R1_FILE" _R1.fastq.gz)
    
    # Define the reverse read file
    R2_FILE="$RAW_DATA_DIR/${BASENAME}_R2.fastq.gz"

    echo ""
    echo "--- PROCESSING SAMPLE: $BASENAME ---"
    echo "Forward read: $R1_FILE"
    echo "Reverse read: $R2_FILE"

    # Check if the reverse read file exists
    if [ ! -f "$R2_FILE" ]; then
        echo "Warning: Reverse read file not found for $BASENAME. Skipping this sample."
        continue
    fi

    # Define output filenames 
    R1_PAIRED_OUT="$TRIMMED_DATA_DIR/${BASENAME}_R1.trimP.fastq.gz"
    R1_UNPAIRED_OUT="$TRIMMED_DATA_DIR/${BASENAME}_R1.trimU.fastq.gz"
    R2_PAIRED_OUT="$TRIMMED_DATA_DIR/${BASENAME}_R2.trimP.fastq.gz"
    R2_UNPAIRED_OUT="$TRIMMED_DATA_DIR/${BASENAME}_R2.trimU.fastq.gz"

    # Run Trimmomatic 
    trimmomatic PE \
        -threads 4 \
        -phred33 \
        "$R1_FILE" \
        "$R2_FILE" \
        "$R1_PAIRED_OUT" \
        "$R1_UNPAIRED_OUT" \
        "$R2_PAIRED_OUT" \
        "$R2_UNPAIRED_OUT" \
        "ILLUMINACLIP:${ADAPTERS_FILE}:2:151:10" \
        LEADING:3 TRAILING:3 SLIDINGWINDOW:4:20 HEADCROP:12 MINLEN:50

    echo " 🪚 Trimming completed for $BASENAME"
done

echo "-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-."
echo " ✂️ All samples successfully trimmed ⭐🌞!"
echo "Trimmed files located at: $TRIMMED_DATA_DIR"
echo "-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-."


YELLOW='\033[1;33m'
GREEN='\033[0;32m'
WHITE='\033[1;37m'
NC='\033[0m'

echo -e "${YELLOW}Sec1: A T G C A T G A C${NC}"
echo -e "${WHITE}      | | |   | | | |  ${NC}"
echo -e "${GREEN}Sec2: A T G T T T G A G${NC}"
echo ""
echo "   -- Trimming complete --"
echo -e "${NC}"
