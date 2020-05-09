## code to prepare `data_kos_sigma`

# import data for all sigma factors classified by KO (KEGG Orthology)
list_data_kos_sigma <- erba::data_to_list(pattern = "K")

## filter by specie: take the biggest genome from each specie to avoid repetitive strains
list_kos_sigma_factor <- purrr::map(list_data_kos_sigma, erba::filter_specie2)

## group all counts per ko in each organism and put them in a table
data_kos_sigma <- erba::list_to_table(list_kos_sigma_factor)
colnames(data_kos_sigma)[1:9] <- erba::kos_sigma # name columns with KO id

## subset table, new table will contain phylogenetic groups with more than 2% of total organisms
data_kos_sigma <- data_kos_sigma %>%
  filter(phylum %in% selected_phylogeny)

# change genome size magnitude
data_kos_sigma <- data_kos_sigma %>%
  mutate_at("ORFs", function(x) x/100)

# save data into the package
usethis::use_data(data_kos_sigma, overwrite = TRUE)

# usage
usethis::use_data("data_kos_sigma")
