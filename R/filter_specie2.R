#' Select organisms with the bigger genome according with a defined vector
#' @param x A data.frame
#' @param names A vector with organism names to select
#' @export
#' @examples
#' # function applyied to one data frame
#' data <- filter_specie(list_data_sigma[[1]])
#' org_names <- data$V1
#' filter_specie2(data, names = org_names)

filter_specie2 <- function(x, names = representative_organisms) {x <- x[x$V1 %in% names,] }
