# filter_best_hits.R
# This script processes BLAST output files to filter best hits per accession based on highest Percent Identity.
# Author: SUBRAMANIAM VIJAYAKUMAR
# Date: 29/05/2025

library(dplyr)

# TODO: Set your directory containing BLAST output files here
data_dir <- "path/to/your/blast/output/files"

# List of BLAST output files to process
files <- c(
  "otu_sample06b_results.out"
)

for (file in files) {
  file_path <- file.path(data_dir, file)
  
  # Check if file exists
  if (!file.exists(file_path)) {
    warning(paste("File not found:", file_path))
    next
  }
  
  # Read the BLAST output file (tab-delimited, header included)
  df <- read.delim(file_path, header = TRUE, stringsAsFactors = FALSE)
  
  # Keep accession column as is (2nd column, typically in gi|...| format)
  df$Accession <- df[[2]]
  
  # Convert PercentIdentity (3rd column) to numeric
  df$PercentIdentity <- as.numeric(df[[3]])
  
  # Filter out rows with missing Accession or PercentIdentity
  df <- df %>% filter(!is.na(Accession) & !is.na(PercentIdentity))
  
  # Select one row per unique Accession with the highest PercentIdentity
  df_clean <- df %>%
    group_by(Accession) %>%
    slice_max(order_by = PercentIdentity, n = 1, with_ties = FALSE) %>%
    ungroup()
  
  # Select columns: OTU (1st column), Accession, and PercentIdentity for output
  output_df <- df_clean %>% select(OTU = 1, Accession, PercentIdentity)
  
  # Write cleaned results to a new file prefixed with "cleaned_"
  output_file <- file.path(data_dir, paste0("cleaned_", file))
  write.table(output_df, file = output_file, sep = "\t", quote = FALSE, row.names = FALSE)
  
  cat(paste("Processed and saved cleaned file:", output_file, "\n"))
}
