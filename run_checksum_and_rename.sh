#!/bin/bash

# This script performs two main tasks:
#  Generates MD5 checksums for all raw FASTQ files to verify file integrity.
#  Renames FASTQ files from common non-standard formats (e.g., _1.fastq.gz)
#  to a standard format (e.g., _R1.fastq.gz) compatible with downstream scripts.

set -euo pipefail # Exit on error, unset variables, or pipeline failures

# --- Directory and Log File Variables ---
RAW_DATA_DIR="./Project/Data/Raw_data"
LOG_DIR="./Project/logs"
LOG_FILE="${LOG_DIR}/checksum_and_rename_$(date +%Y%m%d_%H%M%S).log"

#create directory if not exist and log file
mkdir -p "$LOG_DIR"
touch "$LOG_FILE"

#Redirect all output to a log file and also show in the terminal 
exec &> >(tee -a "$LOG_FILE")

echo "========================================================="
echo "   🧿 Integrity and Filename Check & Rename 👁️ "
echo "========================================================="
echo "Log file: $LOG_FILE"
echo "Target directory: $RAW_DATA_DIR"
echo "---------------------------------------------------------"

#MD5 Checksum Generation 
echo ""
echo "--- Part 1: Generating MD5 Checksums 🧿 ---"

if [ ! -d "$RAW_DATA_DIR" ]; then
    echo "Error: Raw data directory not found at '$RAW_DATA_DIR'"
    exit 1
fi

# Temporarily navigate into the data directory
cd "$RAW_DATA_DIR"

# Check if there are any fastq.gz files to process
if compgen -G "*.fastq.gz" > /dev/null; then
    echo "Calculating MD5 checksums for all *.fastq.gz files..."
    md5sum *.fastq.gz > md5sum.txt
    echo "🧿👁️ MD5 checksums saved to '$RAW_DATA_DIR/md5sum.txt'"
else
    echo "Warning: No *.fastq.gz files found. Skipping checksum generation."
fi

# Navigate back to the original directory
cd - > /dev/null

# Part 2: Filename Validation and Renaming 
echo ""
echo "--- Part 2: Validating and Renaming Files ---"
echo "Standardizing to _R1.fastq.gz and _R2.fastq.gz format..."

# Loop through all fastq.gz files in the raw data directory
for file in "$RAW_DATA_DIR"/*.fastq.gz; do
    
    # Skip if no files are found
    [ -e "$file" ] || continue

    filename=$(basename "$file")

    # Check for _1.fastq.gz and rename to _R1.fastq.gz 
    if [[ "$filename" == *"_1.fastq.gz" ]]; then
        new_name="${file%_1.fastq.gz}_R1.fastq.gz"
        echo "RENAMING: $file -> $new_name"
        mv "$file" "$new_name"
    
    #Check for _2.fastq.gz and rename to _R2.fastq.gz 
    elif [[ "$filename" == *"_2.fastq.gz" ]]; then
        new_name="${file%_2.fastq.gz}_R2.fastq.gz"
        echo "RENAMING: $file -> $new_name"
        mv "$file" "$new_name"
    fi
done

echo "-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-."
echo "🌞👁️ Filename validation and renaming process complete."
echo "-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-."

GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${GREEN}"
echo " +---------------------------+"
echo " | fc66501@loki:~$ checksum  |"
echo " |fc66501@loki:~$ file_sample|"
echo " | Compiling...              |"
echo " | Success!                  |"
echo " |                           |"
echo " +--------------------------+"
echo "      \\   /"
echo "       \ /"
echo -e "${NC}"
