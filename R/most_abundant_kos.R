#' principal_ko
#'
#' @description prints the columns with highest total values from data frame
#' @param data_frame data.frame object from where the data is taken
#' @param column column name where the filter is applied
#' @param filter pattern to match in the filtering column
#' @param from from which column the filter is doing
#' @param to last column to filter
#' @param k number of top columns you want to obtain
#' @examples principal_ko(sigma_filtered, sigma_filtered$group, "Proteobacteria", 1, 20, 6)
#' @export
principal_ko <- function(data_frame, column, filter, from, to, k) {
  l <- colSums(subset(data_frame, column %like% filter)[from:to])
  main <- tail(sort(l),k)
  return(main)
}

#' plot_principal
#'
#' @description Takes a vector of columns names,
#' obtains the total values per column and normalizes them
#' versus the total of regulators found per phylogenetic group.
#' Then plots in facet wrap style all the columns with the highest percent values.
#' Exports the graph in tiff format in the actual directory.
#' @param vector_kos takes a vector with the column names to graph
#' @param data_frame data.frame object with the data
#' @param tiff_file name of the image written inside " "
#' @param myTitle graph title written inside " "
#' @examples plot_principal(my_principal_kos,sigma_filtered, "example.tiff", "Principal sigma factors")
#' @import ggplot2
#' @import data.table
#' @export
plot_principal <- function(vector_kos, data_frame, tiff_file, myTitle) {
  principal_tr <- data.frame(matrix(,ncol=0,nrow=10))
  for (i in vector_kos) {
    principal_tr[,i] <- vector(length = length(selected_phylogeny))
    for (j in selected_phylogeny)
    {
      x <- subset(data_frame, data_frame$group %like% j)
      principal_tr[j,i] <- colSums(x[i])*100/colSums(x["total"])
    }
  }
  principal_tr <- principal_tr[-c(1:10),]
  setDT(principal_tr,keep.rownames = TRUE)
  colnames(principal_tr)[1] <- "group"
  principal_tr_long <- melt(principal_tr, id.vars = "group")
  View(principal_tr_long)

  tiff(tiff_file, width = 1234, height = 880, units = 'px', res = 100)
  my_plot <- ggplot(principal_tr_long) +
    geom_bar(aes(x = 1, y = value, fill = group), stat = "identity", position = "dodge") +
    facet_wrap(~variable, nrow = 5, ncol = 6) +
    ylab("%") +
    ggtitle(myTitle) +
    theme(axis.text.x = element_blank(),
          axis.ticks.x = element_blank(),
          axis.title.x = element_blank(),
          axis.title.y = element_text(angle = 0, vjust = 0.5),
          panel.background = element_blank(),
          panel.grid = element_line(color = "grey"),
          legend.title = element_blank(),
          legend.text = element_text(size = 16),
          axis.title = element_text(size = 16),
          axis.text = element_text(size = 12),
          plot.title = element_text(hjust = 0.5, size = 18)) +
    scale_fill_manual(values = colors_groups)
  print(my_plot)
  dev.off()

}


