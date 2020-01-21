#' select the organism with bigger genome
#'
#' For each specie name allocated in V4, selects the organism with the biggest genome, given by the number of ORFs in V2.
#'
#' @param x data.frame to filtering
#'
#' @return data.frame of the organisms with biggest genomes and their quantification of KOs per genome.
#' @export
#'
#' @examples
#' # function applyied to one data frame
#' filter_specie(list_data_sigma[[1]])
filter_specie <- function(x) { x <- x[x[,.I[V2 == max(V2)],by = V4]$V1] }
