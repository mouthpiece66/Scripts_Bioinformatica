#!/bin/bash

# This script creates the complete project directory structure required for 
# the bioinformatics QC pipeline. It generates all folders used for raw data,
# trimming, quality control, MultiQC, checksums, logs, and downstream analysis.
# 
# Running it multiple times is safe and will not overwrite
# existing folders. This ensures a consistent and reproducible environment 
# for all subsequent scripts.

# The script assumes that you are in the main directory ( Project_ibbc_nathalia)

PROJECT_DIR="./Project"
LOG_DIR="$PROJECT_DIR/logs"
LOG_FILE="$LOG_DIR/create_directories_$(date +%Y%m%d_%H%M%S).log"

mkdir -p "$LOG_DIR"

# Show output live and save to log
exec > >(tee -a "$LOG_FILE") 2>&1

echo "=============================================="
echo "🔧🛠️ Creating Project Directory Structure🔧🛠️"
echo "=============================================="
echo "Log file: $LOG_FILE"
echo ""




# Array of subdirectories to create (without including the project name)
DIRS=(
    "$PROJECT_DIR/Data/Raw_data"
    "$PROJECT_DIR/Tools/Fastqc"
    "$PROJECT_DIR/Tools/Fastqc_trimmed"
    "$PROJECT_DIR/Tools/Trimmed_data"
    "$PROJECT_DIR/Tools/Multiqc_report"
    "$PROJECT_DIR/Tools/Checksums"
    "$PROJECT_DIR/Tools/Scripts"
    "$PROJECT_DIR/logs"
    "$PROJECT_DIR/Downstream_analysis/Alignment"
)


echo "Creating subdirectories in the current location: $(pwd)"


# Iterate over the array to create subdirectories
for d in "${DIRS[@]}"; do
    # 'mkdir -p' creates the directory if it does not exist.
    mkdir -p "$d"
    echo "  - Created: $d"
done

echo "-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-."
echo "  ⭐🌞Successfully created internal structure 🔧🛠️"
echo "-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-."

PURPLE='\033[0;35m'
NC='\033[0m'

echo -e "${PURPLE}"
echo "  /\\__/\\"
echo "  ( o.o )"
echo "   > ^ <"
echo "  /  -  \\"
echo " /_______\\"
echo -e "${NC}"
