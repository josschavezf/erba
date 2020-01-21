## code to prepare `kos_tf` dataset

kos_tf <- erba::get_kos("tf")

# save data into the package
usethis::use_data_raw(name = "kos_tf")
usethis::use_data(kos_tf)

# usage
usethis::use_data("kos_tf")
