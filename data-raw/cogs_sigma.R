## code to prepare `cogs_sigma` dataset

file <- "Supplementary_Table_2.txt"
cogs_sigma <- readr::read_tsv(file)
cogs_sigma <- cogs_sigma$COG

# save data into the package
usethis::use_data(cogs_sigma, overwrite = TRUE)

# usage
usethis::use_data("cogs_sigma")
