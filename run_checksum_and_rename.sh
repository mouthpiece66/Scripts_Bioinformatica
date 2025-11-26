#!/bin/bash

# This script performs two main tasks:
# 1) Normalizes FASTQ filenames:
#    - Renames non-standard patterns (e.g., _1.fastq.gz, _2.fastq.gz)
#      to standard  format (_R1.fastq.gz, _R2.fastq.gz).
#    - Collapses Illumina lane suffixes (e.g., _R1_001.fastq.gz,
#      _R1_002.fastq.gz, _R2_003.fastq.gz → _R1.fastq.gz / _R2.fastq.gz).
#
# 2) Generates one MD5 checksum per file:
#  Integryty verification for FASTQ and alignment files:
#    - Supports .fastq.gz, .fq.gz, .sam, .bam.
#    - Saves each checksum as <filename>.md5 in:
#          Project/Tools/Checksums/
#
# Output is logged and shown live using tee.

# Exit on error
set -euo pipefail 

# Directory and Log File Variable

PROJECT_DIR="./Project"
RAW_DATA_DIR="$PROJECT_DIR/Data/Raw_data"
MD5_DIR="$PROJECT_DIR/Tools/Checksums"
LOG_DIR="$PROJECT_DIR/logs"

# Log file name with date + time
LOG_FILE="$LOG_DIR/checksum_and_rename_$(date +%Y%m%d_%H%M%S).log"

#create directory if not exist and log file
mkdir -p "$LOG_DIR"
mkdir -p "$MD5_DIR"
mkdir -p "$RAW_DATA_DIR"
touch "$LOG_FILE"

#Redirect all output to a log file and also show in the terminal 
exec > >(tee -a "$LOG_FILE") 2>&1


echo "=============================================================="
echo "    🧿 MD5 PER SAMPLE + ADVANCED RENAME HANDLING SCRIPT 👁️"
echo "=============================================================="
echo "Raw data directory : $RAW_DATA_DIR"
echo "MD5 output folder  : $MD5_DIR"
echo "--------------------------------------------------------------"


echo "--- NORMALIZING FILENAMES ---"


shopt -s extglob  #Avoiding errors if no files match

#loop through every file inside RAW_DATA_DIR
#For each file, I extract just the filename and check whether it 
#matches with naming patterns

for file in "$RAW_DATA_DIR"/*; do
    
    base=$(basename "$file")   #Extract filename only / basename removes path

    # Skip if not a regular file
    [ -f "$file" ] || continue

    
    # 1) Rename ANY sample  like _R1_###.fastq.gz


    if [[ "$base" =~ _R1_[0-9]{3}\.fastq\.gz$ ]]; then
        new_name="${file%_R1_*}_R1.fastq.gz"
        echo "RENAMING lane: $base  →  $(basename "$new_name")"
        mv "$file" "$new_name"
        continue
    fi

    if [[ "$base" =~ _R2_[0-9]{3}\.fastq\.gz$ ]]; then
        new_name="${file%_R2_*}_R2.fastq.gz"
        echo "RENAMING lane: $base  →  $(basename "$new_name")"
        mv "$file" "$new_name"
        continue
    fi

    
# 2_Rename simple patterns (_1.fastq.gz → _R1.fastq.gz)
#Create an rename rules associative array
#second loop to check the filename ends with any of the patterns
    declare -A patterns=(
        ["_1.fastq.gz"]="_R1.fastq.gz"
        ["_2.fastq.gz"]="_R2.fastq.gz"
        ["_1.fq.gz"]="_R1.fq.gz"
        ["_2.fq.gz"]="_R2.fq.gz"
    )

    for p in "${!patterns[@]}"; do
        if [[ "$base" == *"$p" ]]; then
            new_name="${file%$p}${patterns[$p]}"
            echo "RENAMING: $base  →  $(basename "$new_name")"
            mv "$file" "$new_name"
            continue 2
        fi
    done
done



# PART 2 – MD5 SUM


echo ""
echo "--- GENERATING ONE MD5 PER FILE ---"

shopt -s extglob nullglob #Avoiding errors if no files match

#Create MD5 checksums integrity verification and for supported file types(fastq.gz, fq.gz, sam, bam)
# And save each checksum as <filename>.md5 in MD5_DIR

for file in "$RAW_DATA_DIR"/*.{fastq.gz,fq.gz,sam,bam}; do

    [ -e "$file" ] || continue

    base=$(basename "$file")

    MD5_OUT="$MD5_DIR/${base}.md5"

    echo "MD5 for: $base → $MD5_OUT"
    md5sum "$file" > "$MD5_OUT"

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
