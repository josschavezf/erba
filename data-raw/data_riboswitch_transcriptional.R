## code to prepare `data_riboswitch_transcriptional` dataset goes here

## import count of riboswitches per organism per Rfam class
riboswitch_transcriptional <- readr::read_tsv("table_transcriptional_riboswitches", col_names = FALSE)

## group occurrence of riboswitches per organism
data_riboswitch_transcriptional <- erba::transform_riboswitch(riboswitch_transcriptional)

# save data into the package
usethis::use_data(data_riboswitch_transcriptional, overwrite = TRUE)

# usage
usethis::use_data("data_riboswitch_transcriptional")
