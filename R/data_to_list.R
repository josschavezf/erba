#' data_to_list
#'
#' @param path path to directory with files
#' @param pattern pattern to select files
#'
#' @description Takes all files which names match pattern provided for the user and put them in a list
#' @examples list_data_sigma <- data_to_list(path = "Documents/", pattern = "K")
#' @export
data_to_list <- function(path = "./", pattern = NULL) {
  files_list <- list.files(path, pattern)
  names(files_list) <- files_list
  files_list <- as.list(files_list)

  read_files <- function(x) {
    filepath <- paste0(path, files_list[[x]])
    read.delim(filepath, header=FALSE, sep = "\t")
  }

  imported_files <- lapply(files_list, read_files)
  return(imported_files)
}
