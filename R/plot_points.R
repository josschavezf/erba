#' plot_points
#'
#' @description plot total regulators versus ORFs per genome
#'
#' @param data A data.frame object
#' @param x variable name
#' @param y variable name
#' @param type either "general" or "groups" for plotting per phylogenetic group
#' @param filename file name with .tiff extension
#' @param title plot title
#' @param xlab x-axis title
#' @param ylab y-axis title
#' @param ymax A number setting the ylab superior limit.
#' @param model.degree Degrees for the polynomial regression model. By default model.degree = 1.
#'
#' @examples
#' plot_points(data = data_kos_sigma, type = "general", filename = "example_general.tiff", title = "Sigma factors", ylab = "Sigma factors per genome", ymax = 120)
#' plot_points(data = data_kos_sigma, type = "groups", filename = "example_groups.tiff", title = "Sigma factors", ylab = "Sigma factors per genome", ymax = 120 )
#' @export
plot_points <- function(data, type = "general", x, y,filename = "figure.tiff", title = "", xlab = "" ,ylab = "", ymax = 200, model.degree = 1 ) {
  mytheme <- theme(panel.grid.major = element_blank(),
                   panel.grid.minor = element_blank(),
                   panel.background = element_blank(),
                   plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
                   axis.line = element_line(colour = "black", size = 1.2),
                   axis.title = element_text(size = 14, face = "bold"),
                   axis.text = element_text(size = 12, face = "bold"),
                   axis.ticks = element_line(size = 1.2, lineend = 2),
                   legend.title = element_blank(),
                   legend.position = c(0.13,0.7),
                   legend.text = element_text(size = 8),
                   legend.key.size = unit(0.45, "cm"))

  if (type == "general") {
    myplot <- ggplot(data, aes(x, y)) +
      geom_point(size = 0.5) +
      ylim(0, ymax) +
      xlim(0,100) +
      geom_smooth(method="lm", se=FALSE, size = 0.5) +
      ggtitle(title) +
      labs(x= xlab,y = ylab) +
      mytheme +
      scale_color_manual(values = colors_groups,  aesthetics = "colour")
  }
  if (type == "groups") {
    myplot <- ggplot(data, aes(x , y, colour = phylum)) +
      geom_point(size = 0.5) +
      ylim(0, ymax) +
      xlim(0,100) +
      geom_smooth(method="lm",formula = y ~ x ,se=FALSE, size = 0.5) +
      ggtitle(title) +
      labs(x= xlab,y = ylab) +
      mytheme +
      scale_color_manual(values = colors_groups2,  aesthetics = "colour")
  }
  ggsave(filename, plot = myplot, device = "tiff",
         width = 7, height = 5, units = "cm", dpi = 300,  scale = 2)
}

