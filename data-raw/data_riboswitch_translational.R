## code to prepare `data_riboswitch_translational` dataset goes here

## import count of riboswitches per organism per Rfam class
riboswitch_translational <- readr::read_tsv("translational_riboswitches", col_names = FALSE)

## group occurrence of riboswitches per organism
data_riboswitch_translational <- erba::transform_riboswitch(riboswitch_translational)

# save data into the package
usethis::use_data(data_riboswitch_translational, overwrite = TRUE)

# usage
usethis::use_data("data_riboswitch_translational")
