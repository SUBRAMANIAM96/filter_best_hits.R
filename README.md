# Filter Best Hits from BLAST Output

This R script processes BLAST output files to retain only the best hit per unique accession based on the highest Percent Identity.

---

## Overview

- Reads tab-delimited BLAST output files with accession numbers in the second column.  
- Converts Percent Identity to numeric and filters out missing data.  
- For each unique accession, keeps only the row with the highest Percent Identity.  
- Outputs cleaned files prefixed with `cleaned_` in the same directory as the input files.

---

## Requirements

- R (version 3.5 or higher recommended)  
- `dplyr` package installed. Install with:  
  ```r
  install.packages("dplyr")

Usage Instructions

    Set your data directory
    Edit the script and update the line:

data_dir <- "path/to/your/blast/output/files"

to the folder containing your BLAST output files.

Add your BLAST output filenames
Update the files vector with your BLAST output file names, e.g.:

files <- c("otu_sample06b_results.out")

Run the script

    Rscript filter_best_hits.R

    Output
    Cleaned output files will be saved in the same directory as the input files with the prefix cleaned_.

Author and Date

    Author: SUBRAMANIAM VIJAYAKUMAR

    Date: 29/05/2025

