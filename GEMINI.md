# Project Overview

This project consists of a set of shell scripts for managing and processing bioinformatics data. The scripts are designed to create a standardized project directory structure and run common bioinformatics tools like FastQC.

## Key Files

*   `create_directories.sh` / `create.directories2.sh`: These scripts set up the project's directory structure. This includes folders for raw data, analysis tools, and results.
*   `run_fastqc_raw.sh`: This script automates the process of running FastQC on raw sequencing data (`.fastq.gz` files). It logs its progress and places the output in a designated directory.
*   `Project/`: This is the main directory containing the project's data, scripts, and results.

## Building and Running

These scripts are designed to be executed directly from the shell.

**Prerequisites:**

*   `fastqc` must be installed and in the system's PATH.

**Running the scripts:**

1.  **Create the project structure:**
    ```bash
    ./create_directories.sh 
    ```
    or
    ```bash
    ./create.directories2.sh
    ```

2.  **Run FastQC on raw data:**
    ```bash
    ./run_fastqc_raw.sh
    ```

## Development Conventions

*   Scripts use `mkdir -p` to create directories, which avoids errors if the directories already exist.
*   The `run_fastqc_raw.sh` script uses a log file to record its output, which is a good practice for tracking the execution of automated tasks.
*   The scripts use variables for directory paths, which makes them easier to modify and maintain.
