## code to prepare `kos_riboswitch` dataset goes here

rfam_riboswitch <- colnames(data_riboswitch[2:33])

# save data into the package
usethis::use_data(rfam_riboswitch, overwrite = TRUE)

# usage
usethis::use_data("rfam_riboswitch")
