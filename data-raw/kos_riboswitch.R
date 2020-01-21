## code to prepare `kos_riboswitch` dataset goes here

kos_riboswitch <- colnames(data_riboswitch[2:33])

# save data into the package
usethis::use_data_raw("kos_riboswitch")
usethis::use_data(kos_riboswitch, overwrite = TRUE)

# usage
usethis::use_data("kos_riboswitch")
