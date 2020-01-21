#' phylogeny_percent
#' @description get abundance percent per phylogenetic group and gives the groups above of threshold
#' @param inputTable table to count percent
#' @param percent_num cutoff of abundance percent
#' @examples
#'  # see phylogenies with representativity of at least 2%
#'  major_phylogenies <- phylogeny_percent(table_sigma, 2)
#' @export
phylogeny_percent <- function(inputTable, percent_num) {
  myInput <- inputTable
  myCount <- summary(myInput$group)
  myCount <- as.table(myCount)
  myCount <- as.data.frame(myCount)
  myCount$percent <- (myCount$Freq/sum(myCount$Freq))*100
  myTable <- subset(myCount, myCount$percent >= percent_num)
  return(myTable)
}

#' selected_phylogeny
#' @description imports the phylogeny vector names with abundance above of 2%
#' @export
selected_phylogeny <- sort(c("Actinobacteria", "Bacteroidetes", "Euryarchaeota",
                             "Firmicutes", "Proteobacteria", "Spirochaetes",
                             "Tenericutes", "Planctomycetes", "Verrucomicrobia", "Chlamydiae"))
