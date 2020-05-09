## code to prepare `kos_tf` dataset

kos_tf <- list.files("transcription_factor/")

# save data into the package
usethis::use_data(kos_tf, overwrite = TRUE)

# usage
usethis::use_data("kos_tf")
