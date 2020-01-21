## code to prepare `data_kos_sigma`

# import data for all sigma factors classified by KO (KEGG Orthology)

list_data_sigma <- erba::data_to_list("K")

## filter by specie: take the biggest genome from each specie to avoid repetitive strains

sigma_factor <- purrr::map(list_data_sigma, erba::filter_specie2)

## group all counts per ko in each organism and put them in a table

data_kos_sigma <- erba::group_to_table(sigma_factor)
colnames(data_kos_sigma)[1:9] <- erba::kos_sigma # name columns with KO id

## subset table, new table will contain phylogenetic groups with more than 2% of total organisms
data_kos_sigma <-  data_kos_sigma[data_kos_sigma$group %in% erba::selected_phylogeny,]

## remove organisms with non information about their genome size, it means they have ko information but non .faa file

data_kos_sigma <- subset(data_kos_sigma, data_kos_sigma$ORFs > 0)

# change genome size magnitude

data_kos_sigma$ORFs <- data_kos_sigma$ORFs/100

## set breaks in genome size

numbers_sf = seq(from = 0, to = 100, by= 5)
total_groups <- seq(from = 0, to = 200, by = 10)

data_kos_sigma$breakORFs <- cut(data_kos_sigma$ORFs, breaks = c(numbers_sf, 200))
data_kos_sigma$breakTotal <- cut(data_kos_sigma$total, breaks = total_groups, include.lowest = TRUE)

# save data into the package
usethis::use_data_raw(name = "data_kos_sigma")
usethis::use_data(data_kos_sigma, overwrite = TRUE)

# usage
usethis::use_data("data_kos_sigma")
