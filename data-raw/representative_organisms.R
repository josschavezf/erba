## code to prepare `representative_organisms` dataset goes here
# import data for all sigma factors classified by KO (KEGG Orthology)

list_data_sigma <- erba::data_to_list("K")

## filter by specie: take the biggest genome from each specie to avoid repetitive strains
representative_organisms <-  filter_specie(list_data_sigma[[1]])
representative_organisms <- representative_organisms$V1

# save data into the package
usethis::use_data(representative_organisms, overwrite = TRUE)

# usage
usethis::use_data("representative_organisms")
