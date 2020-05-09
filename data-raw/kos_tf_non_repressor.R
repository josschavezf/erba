## code to prepare `kos_tf_non_repressor` dataset goes here

# import ko names for non-repressor TFs

kos_tf_non_repressor <- readr::read_tsv("kos_transcription_factor_non_repressor", col_names = FALSE)
kos_tf_non_repressor <- kos_tf_non_repressor$X1

# save data into the package
usethis::use_data(kos_tf_non_repressor, overwrite = TRUE)

# usage
usethis::use_data("kos_tf_non_repressor")
