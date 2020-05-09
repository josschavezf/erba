## code to prepare `data_kos_tf` dataset

## import data for all transcription factors classified by KO (KEGG Orthology)
list_data_kos_tf <- erba::data_to_list("K", path = "~/Dropbox/IBT/laboratorio/tablas_conteo/conteo_kos/transcription_factor/")

## filter by specie: take the biggest genome from each specie to avoid repetitive strains
list_kos_transcription_factor <- purrr::map(list_data_kos_tf, erba::filter_specie2)

## group all counts per ko in each organism and put them in a table
data_kos_tf <- erba::list_to_table(list_kos_transcription_factor)
colnames(data_kos_tf)[1:369] <- kos_tf # name columns with KO id

## subset table_tf, new table will contain phylogenetic groups with more than 2% of total organisms
data_kos_tf <- data_kos_tf %>%
  filter(phylum %in% selected_phylogeny)

## change genome size magnitude
data_kos_tf$ORFs <- data_kos_tf$ORFs/100

# save data into the package
usethis::use_data(data_kos_tf, overwrite = TRUE)

# usage
usethis::use_data("data_kos_tf")
