#' phylogeny_percent
#' @description get abundance percent per phylogenetic group and gives the groups above of threshold
#' @param x A data.frame
#' @param percent_num cutoff of abundance percent
#' @examples
#'  # see phylogenies with representativity above 2%
#'  major_phylogenies <- phylogeny_percent(table_sigma, 2)
#' @export
phylogeny_percent <- function(x, percent = 0) {
  Count <- summary(x$group) %>% data.frame()
  Count$percent <- (Count$./sum(Count$.))*100
  df <-  Count[Count$percent >= percent,]
  return(df)
}
