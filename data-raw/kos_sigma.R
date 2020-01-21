## code to prepare `kos_sigma` dataset

kos_sigma <- erba::get_kos("sigma")

# save data into the package
usethis::use_data_raw(name = "kos_sigma")
usethis::use_data(kos_sigma)

# usage
usethis::use_data("kos_sigma")

