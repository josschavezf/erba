#' plot_distribution
#'
#' @description plot total organisms versus ORFs per genome range
#' @param data A data.frame object
#' @param filename file name inside " "
#' @param title file name with .tiff extension
#' @import ggplot2
#' @examples
#' plot_distribution(sigma_filtered,
#' filename = "bar_example.tiff",
#' title = "bar distribution")
#' @export
plot_distribution <- function(data, filename, title) {
  myTable <- na.omit(subset(data, select = c(breakORFs, breakTotal, group )))
  tiff(filename = filename, width = 1234, height = 880, units = 'px', res = 100)
  myplot <- ggplot(myTable) +
    geom_bar(aes(breakORFs ,fill = group), color = "black", position = position_stack(reverse = TRUE)) +
    ggtitle(title) +
    ylim(0,300) +
    labs( x = "ORFs (x 100)", y = "Number of organisms") +
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
          panel.background = element_blank(),
          plot.title = element_text( size = 28, face = "bold", hjust = 0.5),
          axis.line = element_line(colour = "black", size = 1.5),
          axis.text.x = element_text(angle = 90),
          axis.title = element_text(size = 26, face = "bold"),
          axis.text = element_text(size = 22, face = "bold"),
          axis.ticks = element_line(size = 1.5, lineend = 2),
          legend.title = element_blank(),
          legend.position = c(0.87,0.6),
          legend.text = element_text(size = 20, face = "bold"),
          legend.key.size = unit(0.45, "in")) +
    scale_fill_manual(values = colors_groups)
  print(myplot)
  dev.off()

}
