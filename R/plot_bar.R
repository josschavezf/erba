#' plot_bar
#'
#' @description plot total regulators versus ORFs per genome
#' @param data A data.frame object
#' @param filename file name with .tiff extension
#' @param title plot name inside " "
#' @param addLegend default = TRUE
#' @import ggplot2
#' @examples
#' plot_bar(data_kos_sigma,
#' filename = "bar_example.tiff",
#' title = "bar distribution")
#'
#' plot_bar(data_kos_sigma,
#' filename = "bar_example.tiff",
#' title = "bar distribution",
#' addLegend = FALSE)
#' @export
plot_bar <- function(data, filename, title, add.legend = TRUE, legend.title = "") {
  myTable <- na.omit(subset(data, select = c(breakORFs, breakTotal, group )))
  brks <- c(0, 0.25, 0.5, 0.75, 1)
  if (add.legend == TRUE)
  {
    tiff(filename = filename, width = 1234, height = 880, units = 'px', res = 100)
    myplot <- ggplot(data) +
      geom_bar(aes(breakORFs ,fill = breakTotal),  position = position_fill()) +
      ggtitle(title) +
      ylim(0,300) +
      labs( x = "ORFs (x 100)", y = "%") +
      theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
            panel.background = element_blank(),
            plot.title = element_text( size = 28,face = "bold", hjust = 0.5),
            axis.line = element_line(colour = "black", size = 1.5),
            axis.ticks = element_line(size = 1.5, lineend = 2),
            axis.text.x = element_text(angle = 90),
            axis.title = element_text(size = 26, face = "bold"),
            axis.text = element_text(size = 22, face = "bold"),
            legend.title = element_blank(),
            legend.position = c(0.9,0.55),
            legend.text = element_text(size = 18, face = "bold"),
            legend.key.size = unit(0.25, "in")) +
      guides(fill= guide_legend(title = legend.title)) +
      scale_fill_manual(values = colors_total)
    print(myplot)
    dev.off()

  } else {
    tiff(filename = filename, width = 1234, height = 880, units = 'px', res = 100)
    myplot <- ggplot(data) +
      geom_bar(aes(breakORFs ,fill = breakTotal),  position = position_fill(reverse = TRUE)) +
      ggtitle(title) +
      scale_y_continuous(breaks = brks, labels = scales::percent(brks)) +
      labs( x = "ORFs (x 100)", y = "") +
      theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
            panel.background = element_blank(),
            plot.title = element_text( size = 28,face = "bold", hjust = 0.5),
            axis.line = element_line(colour = "black", size = 1.5),
            axis.ticks = element_line(size = 1.5, lineend = 2),
            axis.text.x = element_text(angle = 90),
            axis.title = element_text(size = 26, face = "bold"),
            axis.text = element_text(size = 22, face = "bold"),
            legend.position = "none") +
      scale_fill_manual(values = colors_total)
    print(myplot)
    dev.off()
  }

}
