## code to prepare `cogs_tf` dataset

file <- "Supplementary_Table_1.txt"
cogs_tf <- readr::read_tsv(file)
cogs_tf <- cogs_tf$COG

# save data into the package
usethis::use_data(cogs_tf, overwrite = TRUE)

# usage
usethis::use_data("cogs_tf")

