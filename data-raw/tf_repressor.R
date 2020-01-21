## code to prepare `tf_repressor` dataset goes here

# filter data from previous data.frame
tf_repressor <- tf_filtered[, c(kos_tf_repressor,names(tf_filtered[366:371]))]
tf_repressor$total <- rowSums(tf_repressor[1:length(kos_tf_repressor)])

numbers_sf = seq(from = 0, to = 100, by= 5)
total_groups <- seq(from = -0, to = 200, by = 10)
tf_repressor$breakTotal <- cut(tf_repressor$total, breaks = total_groups, include.lowest = TRUE)

# save data into the package
usethis::use_data_raw(name = "tf_repressor")
usethis::use_data(tf_repressor, overwrite = TRUE)

# usage
usethis::use_data("tf_repressor")
