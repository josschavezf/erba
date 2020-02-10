## code to prepare `data_riboswitch` dataset goes here

## import count of riboswitches per organism per Rfam class
riboswitch_transcriptional <- read.table("table_transcriptional_riboswitches", header = FALSE)

## group occurrence of riboswitches per organism
data_riboswitch <- erba::transform_riboswitch(riboswitch_transcriptional)

## set breaks
numbers_sf = seq(from = 0, to = 100, by= 5)
total_groups <- seq(from = 0, to = 200, by = 10)

data_riboswitch$breakORFs <- cut(data_riboswitch$ORFs, breaks = c(numbers_sf,200))
data_riboswitch$breakTotal <- cut(data_riboswitch$total, breaks = c(total_groups), include.lowest = TRUE)

# save data into the package
usethis::use_data_raw(name = "data_riboswitch")
usethis::use_data(data_riboswitch, overwrite = TRUE)

# usage
usethis::use_data("data_riboswitch")
