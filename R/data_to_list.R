#' data_to_list
#' @description Takes all files which names match pattern provided for the user and put them in a list
#' @param list_by pattern to search in actual directory for files to put in the list
#' @examples list_data_sigma <- data_to_list("K")
#' @import ggplot2
#' @import plyr
#' @import data.table
#' @export
data_to_list <- function(list_by) {
  files_list <- list.files(pattern = list_by)
  list_name <- list()
  for (i in 1:length(files_list)) {
    list_name[[i]] <- read.delim(files_list[i], header=FALSE)
    list_name[[i]] <- as.data.table(list_name[[i]])
  }
  return(list_name)
}
