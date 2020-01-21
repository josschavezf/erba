## code to prepare `data_kos_tf` dataset

## import data for all transcription factors classified by KO (KEGG Orthology)
list_data_tf <- erba::data_to_list("K")

## filter by specie: take the biggest genome from each specie to avoid repetitive strains
transcription_factor <- purrr::map(list_data_tf, erba::filter_specie2)

## group all counts per ko in each organism and put them in a table
data_kos_tf <- erba::group_to_table(transcription_factor)
colnames(data_kos_tf)[1:366] <- erba::kos_tf # name columns with KO id

## subset table_tf, new table will contain phylogenetic groups with more than 2% of total organisms
data_kos_tf <- data_kos_tf[data_kos_tf$group %in% erba::selected_phylogeny,]

## remove organisms with non information about their genome size, it means they have ko information but non .faa file
data_kos_tf <- subset(data_kos_tf, data_kos_tf$ORFs > 0)

## change genome size magnitude
data_kos_tf$ORFs <- data_kos_tf$ORFs/100

## set breaks in genome size
data_kos_tf$breakORFs <- cut(data_kos_tf$ORFs, breaks = c(numbers_sf, 200))
data_kos_tf$breakTotal<- cut(data_kos_tf$total, breaks = total_groups, include.lowest = TRUE)

# save data into the package
usethis::use_data_raw(name = "data_kos_tf")
usethis::use_data(data_kos_tf, overwrite = TRUE)

# usage
usethis::use_data("data_kos_tf")
