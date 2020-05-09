## code to prepare `kos_tf_repressor` dataset goes here

# import ko names for non-repressor TFs

kos_tf_repressor <- readr::read_tsv("kos_transcription_factor_repressor", col_names = FALSE)
kos_tf_repressor <- kos_tf_repressor$X1

# save data into the package
usethis::use_data(kos_tf_repressor, overwrite = TRUE)

usethis::use_data("kos_tf_repressor")
