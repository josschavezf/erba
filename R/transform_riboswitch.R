#' transform_riboswitch
#'
#' @description re-order counts of riboswitches per organism and adds genomes information.
#'
#' @param x A data frame with organism, gene and riboswitch columns.
#'
#' @return A \code{data.frame} with counts of riboswitches per organism and genome information.
#' @import dplyr
#' @export
transform_riboswitch <- function(x) {
  m <- erba::data_kos_tf %>%
    dplyr::select(organism, ORFs, phylum, class)
  x <- x
  colnames(x) <- c("organism", "gene", "riboswitch")
  x_rows <- dplyr::distinct(x, riboswitch) %>% nrow()
  x <- x %>%
    group_by(organism) %>%
    dplyr::count(riboswitch)
  x <- reshape2::dcast(x, organism ~ riboswitch)
  y <- merge(x,m, all= TRUE)
  y[is.na(y)] <- 0
  y$total <- rowSums(y[,2:x_rows])
  return(y)
}
