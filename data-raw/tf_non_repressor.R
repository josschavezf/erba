## code to prepare `tf_non_repressor` dataset goes here


# filter data from previous data.frame
tf_non_repressor <- tf_filtered[, c(kos_tf_non_repressor, names(tf_filtered[366:371]))]
tf_non_repressor$total <- rowSums(tf_non_repressor[1:length(kos_tf_non_repressor)])

numbers_sf = seq(from = 0, to = 100, by= 5)
total_groups <- seq(from = -0, to = 200, by = 10)
tf_non_repressor$breakTotal <- cut(tf_non_repressor$total, breaks = total_groups, include.lowest = TRUE)

# save data into the package
usethis::use_data_raw(name = "tf_non_repressor")
usethis::use_data(tf_non_repressor, overwrite = TRUE)

# usage
usethis::use_data("tf_non_repressor")
