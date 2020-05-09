## code to prepare `tf_repressor` dataset goes here

# filter data from previous data.frame

tf_repressor <- data_kos_tf %>%
  select(all_of(kos_tf_repressor), total, organism, ORFs, phylum, class )

tf_repressor$total <- rowSums(tf_repressor[1:length(kos_tf_repressor)])

# save data into the package
usethis::use_data(tf_repressor, overwrite = TRUE)

# usage
usethis::use_data("tf_repressor")
