#!/bin/bash

# The script assumes that you are in the main directory ( Project_ibbc_nathalia)

# Array of subdirectories to create (without including the project name)
SUB_DIRS=(
    "Project/Data/Raw_data"
    "Project/Tools/Fastqc"
    "Project/Tools/Fastqc_trimmed"
    "Project/Tools/Trimmed_data"
    "Project/Tools/Multiqc_report"
    "Project/Tools/Scripts"
    "Project/Downstream_analysis/Alignment"
    "Project/logs"
)


echo "Creating subdirectories in the current location: $(pwd)"


# Iterate over the array to create subdirectories
for dir in "${SUB_DIRS[@]}"; do
    # 'mkdir -p' creates the directory if it does not exist.
    mkdir -p "$dir"
    echo "  - Created: $dir"
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
