#' data_to_list
#'
#' @param path path to directory with files
#' @param pattern pattern to select files
#'
#' @description Takes all files which names match pattern provided for the user and put them in a list
#' @examples list_data_sigma <- data_to_list(path = "Documents/", pattern = "K")
#' @import ggplot2
#' @import plyr
#' @import data.table
#' @export
data_to_list <- function(path = "./", pattern = NULL) {
  files_list <- list.files(path, pattern)
  list_name <- list()
  for (i in 1:length(files_list)) {
    filepath <- paste0(path, files_list[i])
    list_name[[i]] <- read.delim(filepath, header=FALSE)
    list_name[[i]] <- as.data.table(list_name[[i]])
  }
  return(list_name)
}
