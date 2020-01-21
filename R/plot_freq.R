#' plot frequencies from vector
#' @description takes a vector, counts frequency of the elements and makes a barplot.
#'
#' @param x A vector
#' @param filename filename that ends with .tiff
#' @param title title for the plot
#'
#' @return A barplot into a tiff file.
#' @import plyr
#' @export
#'
#' @examples plot_freq(proteobacteria_labels, tiff_file = "proteobacteria_freq.tiff", plot_title = "Proteobacteria")
plot_freq <- function(x, filename, title) {
  df_count <- plyr::count(x)
  tiff(filename = filename, width = 1234, height = 880, units = 'px', res = 100)
  myplot <- ggplot(df_count, aes(x = reorder(x, -freq), y = freq)) +
    geom_bar(stat = "identity") +
    ggtitle(title) +
    labs( x = "Family", y = "Frequency") +
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
          panel.background = element_blank(),
          plot.title = element_text( size = 28,face = "bold", hjust = 0.5),
          axis.line = element_line(colour = "black", size = 1.5),
          axis.ticks = element_line(size = 1.5, lineend = 2),
          axis.text.x = element_text(angle = 90, hjust = 1),
          axis.title = element_text(size = 26, face = "bold"),
          axis.title.x = element_blank(),
          axis.text = element_text(size = 22, face = "bold"))
  print(myplot)
  dev.off()
}
