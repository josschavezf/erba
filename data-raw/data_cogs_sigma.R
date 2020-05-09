## code to prepare `data_cogs_tf` dataset

## import data for all transcription factors classified by KO (KEGG Orthology)
list_data_cogs_sigma <- erba::data_to_list(pattern = "COG", path = "../../IBT/laboratorio/tablas_conteo/conteo_cogs/sigma_factor/")

## filter by specie: take the biggest genome from each specie to avoid repetitive strains
list_cogs_sigma_factor <- purrr::map(list_data_cogs_sigma, filter_specie2)

## group all counts per ko in each organism and put them in a table
data_cogs_sigma <- erba::list_to_table(list_cogs_sigma_factor)
colnames(data_cogs_sigma)[1:4] <- erba::cogs_sigma # name columns with cog id

## filter table, new table will contain phyla selected
data_cogs_sigma <- data_cogs_sigma %>%
  filter(phylum %in% selected_phylogeny)

## change genome size magnitude
data_cogs_sigma <-data_cogs_sigma %>%
  mutate_at("ORFs", function(x) x/100)

# save data into the package
usethis::use_data(data_cogs_sigma, overwrite = TRUE)

#usage
usethis::use_data("data_cogs_sigma")
