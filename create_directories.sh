#!/bin/bash

# The script assumes that you are in the main directory ( Project_ibbc_nathalia)

# Array of subdirectories to create (without including the project name)
SUB_DIRS=(
    "00_scripts"    
    "01_raw_data"
    "02_fastqc_raw"
    "03_trimmed_data"
    "04_fastqc_trimmed"
    "05_multiqc_report"
    "06_alignment"
    "07_downstream_analysis"
)

echo "Creating subdirectories in the current location: $(pwd)"


# Iterate over the array to create subdirectories
for dir in "${SUB_DIRS[@]}"; do
    # 'mkdir -p' creates the directory if it does not exist.
    mkdir -p "$dir"
    echo "  - Created: $dir"
done

echo "--------------------------------------------------------"
echo "Successfully created internal structure."