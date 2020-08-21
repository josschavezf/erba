#' Plot TFs, Sigmas and Riboswitches versus genome size
#'
#' @param x A `data.frame`
#' @param title Plot title
#' @param filename Filename
#'
#' @return A title.tiff file
#' @import ggplot2
#' @export
#'
#' @examples
#' data %>%
#' filter(phylum == "Actinobacteria") %>%
#' plot_regulators("Actinobacteria")
plot_regulators <- function(x, filename = "", title = "") {
  # define colors
  colors_reg <- c("red", "blue", "darkgreen")
  names(colors_reg) <- c("Sigma factors", "Transcription factors", "Riboswitches")

  tiff(filename = paste0("figures/",filename,".tiff"), width = 1234, height = 880, units = 'px', res = 100)
  myplot <- ggplot(x, aes(x = `ORFs(X100)`, y = total, colour = type)) +
    geom_point() +
    geom_smooth(method = "lm", se = FALSE) +
    labs(x= "ORFs (x 100)",y = "Transcriptional regulators per genome") +
    ggtitle(title) +
    theme(panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.background = element_blank(),
          plot.title = element_text(hjust = 0.5, size = 28, face = "bold"),
          axis.line = element_line(colour = "black", size = 1.5),
          axis.title = element_text(size = 26, face = "bold"),
          axis.text = element_text(size = 22, face = "bold"),
          axis.ticks = element_line(size = 1.5, lineend = 2),
          legend.title = element_blank(),
          legend.position = c(0.165,0.9),
          legend.text = element_text(size = 20, face = "bold"),
          legend.key.size = unit(0.45, "in")) +
    scale_color_manual(values = colors_reg,  aesthetics = "colour")
  print(myplot)
  dev.off()
}
