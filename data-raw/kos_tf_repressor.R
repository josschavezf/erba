## code to prepare `kos_tf_repressor` dataset goes here

# import ko names for non-repressor TFs

kos_tf_repressor <- read.delim("kos_transcription_factor_repressor", header = FALSE)
kos_tf_repressor <- as.character(kos_tf_repressor[[1]])

# save data into the package
usethis::use_data_raw(name = "kos_tf_repressor")
usethis::use_data(kos_tf_repressor, overwrite = TRUE)

usethis::use_data("kos_tf_repressor")
