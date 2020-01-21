## code to prepare `cogs_tf` dataset

file <- "cogs_transcription_factor"
cogs_tf <- read.delim(file, header = FALSE)
cogs_tf <- as.vector(cogs_tf$V1)

# save data into the package
usethis::use_data_raw(name = "cogs_tf")
usethis::use_data(cogs_tf)

# usage
usethis::use_data("cogs_tf")

