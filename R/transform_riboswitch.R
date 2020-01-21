#' transform_riboswitch
#'
#' @description re-order counts of riboswitches per organism and adds genomes information.
#'
#' @param x data frame with organism, gene and riboswitch columns.
#'
#' @return A \code{data.frame} with counts of riboswitches per organism and genome information.
#'
#' @export
transform_riboswitch <- function(x) {
  m <- erba::data_kos_tf[,c("organism","ORFs","group")]
  x <- plyr::count(x,vars = c("V1","V3"))
  y <- reshape2::dcast(x,V1~V3)
  colnames(y)[1] <- "organism"
  y <- merge(y,m, all= TRUE)
  y[is.na(y)] <- 0
  y$total <- rowSums(y[,2:33])
  y$organism <- as.character(y$organism)
  y <- setorder(y, "organism")
  return(y)
}
