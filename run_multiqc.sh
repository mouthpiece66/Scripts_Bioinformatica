#!/bin/bash

# This script runs MultiQC to aggregate reports from various bioinformatics tools.

set -euo pipefail # Exit on error, unset variables, or pipeline failures

#Directory Variables
FASTQC_RAW_DIR="./Project/Tools/Fastqc"
FASTQC_TRIMMED_DIR="./Project/Tools/Fastqc_trimmed"
TRIMMED_DATA_DIR="./Project/Tools/Trimmed_data"
MULTIQC_REPORT_DIR="./Project/Tools/Multiqc_report"
LOG_DIR="./Project/logs"
# LOG_FILE: Unique log file name with timestamp.
LOG_FILE="${LOG_DIR}/multiqc_$(date +%Y%m%d_%H%M%S).log"

#Create Output and Log Directories 
mkdir -p "$MULTIQC_REPORT_DIR"
mkdir -p "$LOG_DIR"
mkdir -p "$FASTQC_TRIMMED_DIR"
touch "$LOG_FILE"

#Redirect Output to Log and Terminal 
exec &> >(tee -a "$LOG_FILE")

echo "========================================================="
echo "      🗒️🧬 STARTING: MultiQC Report Generation 🗒️🧬    "
echo "========================================================="
echo "Log file: $LOG_FILE"
echo "Scanning for reports in:"
echo "  - Raw FastQC: $FASTQC_RAW_DIR"
echo "  - Trimmed FastQC: $FASTQC_TRIMMED_DIR (if reports exist)"
echo "  - Trimmed Data: $TRIMMED_DATA_DIR (for Trimmomatic logs)"
echo "Output report will be saved to: $MULTIQC_REPORT_DIR"
echo "---------------------------------------------------------"

#Run MultiQC.
multiqc \
    "$FASTQC_RAW_DIR" \
    "$FASTQC_TRIMMED_DIR" \
    "$TRIMMED_DATA_DIR" \
    -o "$MULTIQC_REPORT_DIR" \
    -n "multiqc_report.html" \
    -t "MultiQC Report - Raw and Trimmed Data"

echo "-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-."
echo " ⭐🌞 MultiQC report generation complete 📋"
echo "Report available at: $MULTIQC_REPORT_DIR/multiqc_report.html"
echo "-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-."

GREEN='\033[0;32m'  # Verde para las hojas
BROWN='\033[0;33m'   # Amarillo/Marrón para el tronco
YELLOW='\033[1;33m' # Amarillo brillante para la estrella
NC='\033[0m'         # Sin color (resetea)

# Dibujo del árbol de Navidad
echo -e "${YELLOW}           * ${NC}" # Estrella
echo -e "${GREEN}          / \\          ${NC}"
echo -e "${GREEN}         /___\\         ${NC}"
echo -e "${GREEN}        /  o  \\        ${NC}" # Adorno simple
echo -e "${GREEN}       /_______\\       ${NC}"
echo -e "${GREEN}      /   o     \\      ${NC}" # Adorno simple
echo -e "${GREEN}     /___________\\     ${NC}"
echo -e "${GREEN}    /   o  o      \\    ${NC}" # Más adornos
echo -e "${GREEN}   /_______________\\   ${NC}"
echo -e "${BROWN}         | |         ${NC}" # Tronco
echo -e "${BROWN}         |_|         ${NC}" # Base del Tronco