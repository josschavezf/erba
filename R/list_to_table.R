#' list_to_table
#'
#' @description takes a list with data frames of similar size and put them in a single table.
#' The new table contains the regulator factors, organism key, total of regulators per organism, ORFs
#' per genome and phylogenetic group.
#' @param inputList list of data frames with same size and data order
#' @export
list_to_table <- function(inputList) {

  myList <- list()

  for (i in 1:length(inputList)) {
    myList[[i]] <- as.data.frame(inputList[[i]])
  }

  myTable <- data.frame(myList[[1]]$V1, myList[[1]]$V2)

  for (i in 1:length(myList)) {
    nombre <- i
    myTable[nombre] <- myList[[i]]$V3
  }

  colnames(myTable)[1]<- "V1"
  colnames(myTable)[2]<- "V2"

  myTable$total <- rowSums(myTable)
  myTable$organism <- myList[[1]]$V1
  myTable$ORFs <- myList[[1]]$V2
  myTable$phylum <- myList[[1]]$V5
  myTable$class <- myList[[1]]$V6
  return(myTable)

}
