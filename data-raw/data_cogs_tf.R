## code to prepare `data_cogs_tf` dataset

## import data for all transcription factors classified by KO (KEGG Orthology)
list_data_tf <- erba::data_to_list("COG")

## filter by specie: take the biggest genome from each specie to avoid repetitive strains
transcription_factor <- purrr::map(list_data_tf, filter_specie)

## group all counts per ko in each organism and put them in a table
data_cogs_tf <- erba::group_to_table(transcription_factor)
colnames(data_cogs_tf)[1:87] <- erba::cogs_tf # name columns with cog id

## subset table, new table will contain phylogenetic groups with more than 2% of total organisms
data_cogs_tf <- data_cogs_tf[data_cogs_tf$group %in% selected_phylogeny,]

## remove organisms with non information about their genome size, it means they have ko information but non .faa file
data_cogs_tf <- subset(data_cogs_tf, data_cogs_tf$ORFs > 0)

## change genome size magnitude
data_cogs_tf$ORFs <- data_cogs_tf$ORFs/100

## set breaks in genome size
data_cogs_tf$breakORFs <- cut(data_cogs_tf$ORFs, breaks = c(numbers_sf, 200))
data_cogs_tf$breakTotal<- cut(data_cogs_tf$total, breaks = total_groups, include.lowest = TRUE)

# save data into the package
usethis::use_data_raw(name = "data_cogs_tf")
usethis::use_data(data_cogs_tf)

#usage
usethis::use_data("data_cogs_tf")
