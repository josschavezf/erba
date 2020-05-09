## code to prepare `tf_repressor_non_repressor` dataset goes here

organism_data <- data_kos_tf %>% select(organism, ORFs, phylum, class)

tf_repressor_non_repressor <- data.frame(tf_repressor$total, tf_non_repressor$total, organism_data)

colnames(tf_repressor_non_repressor)[1:2] <- c("repressor","non_repressor")

# save data
usethis::use_data(tf_repressor_non_repressor, overwrite = TRUE)

# usage
usethis::use_data("tf_repressor_non_repressor")
