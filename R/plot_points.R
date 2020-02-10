#' plot_points
#'
#' @description plot total regulators versus ORFs per genome
#' @param data A data.frame object
#' @param type either "general" or "groups" for plotting per phylogenetic group
#' @param filename file name with .tiff extension
#' @param title plot name inside " "
#' @param ylab yLab name inside " "
#' @param ylim yLab limit in format (x,y)
#' @examples
#' plot_points(data = data_kos_sigma, type = "general", filename = "example_general.tiff", title = "Sigma factors", ylab = "Sigma factors per genome", ylim = ylim(0,120))
#' plot_points(data = data_kos_sigma, type = "groups", filename = "example_groups.tiff", title = "Sigma factors", ylab = "Sigma factors per genome", ylim = ylim(0,120) )
#' @export
plot_points <- function(data, type = "general", filename = "figure.tiff", title = "", ylab = "", y.lim = ylim(0,200)) {
  if (type == "general") {
    tiff(filename = filename, width = 1234, height = 880, units = 'px', res = 100)
    myplot <- ggplot(data, aes(x = ORFs, y = total)) +
      geom_point() +
      y.lim +
      xlim(0,100) +
      geom_smooth(method="lm", se=FALSE) +
      ggtitle(title) +
      labs(x= "ORFs (x 100)",y = ylab) +
      theme(panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            panel.background = element_blank(),
            plot.title = element_text(hjust = 0.5, size = 28, face = "bold"),
            axis.title = element_text(size = 26, face="bold"),
            axis.text = element_text(size = 22, face = "bold"),
            axis.ticks = element_line(size = 1.5, lineend = 2),
            axis.line = element_line(colour = "black", size=1.5)) +
      scale_color_manual(values = colors_groups,  aesthetics = "colour")
    print(myplot)
    dev.off()
  }
  if (type == "groups") {
    tiff(filename = filename, width = 1234, height = 880, units = 'px', res = 100)
    myplot <- ggplot(data, aes(x = ORFs, y = total, colour = group)) +
      geom_point() +
      y.lim +
      xlim(0,100) +
      geom_smooth(method="lm", se=FALSE) +
      ggtitle(title) +
      labs(x= "ORFs (x 100)",y = ylab) +
      theme(panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            panel.background = element_blank(),
            plot.title = element_text(hjust = 0.5, size = 28, face = "bold"),
            axis.line = element_line(colour = "black", size = 1.5),
            axis.title = element_text(size = 26, face = "bold"),
            axis.text = element_text(size = 22, face = "bold"),
            axis.ticks = element_line(size = 1.5, lineend = 2),
            legend.title = element_blank(),
            legend.position = c(0.13,0.7),
            legend.text = element_text(size = 20),
            legend.key.size = unit(0.45, "in")) +
      scale_color_manual(values = colors_groups2,  aesthetics = "colour")
    print(myplot)
    dev.off()
  }
}

