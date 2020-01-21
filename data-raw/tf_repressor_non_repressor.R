## code to prepare `tf_repressor_non_repressor` dataset goes here

tf_repressor_non_repressor <- data.frame(tf_repressor$total, tf_non_repressor$total, tf_filtered[366:371])
colnames(tf_repressor_non_repressor)[1:2] <- c("repressor","non_repressor")

usethis::use_data_raw("tf_repressor_non_repressor")
usethis::use_data(tf_repressor_non_repressor)

usethis::use_data("tf_repressor_non_repressor")
