#' plot_repressor
#'
#' @description plot repressor and non_repressor transcription factors versus ORFs per genome
#'
#' @param data A data.frame object, needs to have the columns repressor and non_repressor for transcription factors
#' @param filename file name with .tiff extension
#' @param title plot name inside " "
#' @param ymin ylim min
#' @param ymax ylim max
#' @param ylab ylab name inside " "
#'
#' @examples
#' plot_repressor(tf_repressor_non_repressor,
#' filename = "tf_repressor.tiff",
#' ylab = "Transcription factors",
#' title = "Transcription factors per genome",
#' ylim(0,120))
#' @export
plot_repressor <- function(data, filename, title, ylab, ymin = 0, ymax = 150) {
    tiff(filename = filename, width = 1234, height = 880, units = 'px', res = 100)
    myplot <- ggplot(data) +
      geom_point(aes(x = ORFs, y = repressor, colour = "repressor")) +
      geom_point(aes(x = ORFs, y = non_repressor, colour = "non_repressor")) +
      ylim(ymin, ymax) +
      xlim(0,100) +
      geom_abline(aes(intercept = intercept(ORFs, repressor, slope(ORFs,repressor)), slope = slope(ORFs,repressor), color = "repressor")) +
      geom_abline(aes(intercept = intercept(ORFs, non_repressor, slope(ORFs,non_repressor)), slope = slope(ORFs,non_repressor), color = "non_repressor")) +
      ggtitle(title) +
      labs(x= "ORFs (x 100)", y = ylab) +
      theme(panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            panel.background = element_blank(),
            plot.title = element_text(hjust = 0.5, size = 28, face = "bold"),
            axis.title = element_text(size = 26, face="bold"),
            axis.text = element_text(size = 22, face="bold"),
            axis.line = element_line(colour = "black", size=1.5),
            axis.ticks = element_line(size = 1.5, lineend = 2),
            legend.title = element_blank(),
            legend.position = c(0.13,0.85),
            legend.text = element_text(size = 20),
            legend.key.size = unit(0.45, "in")) +
      scale_color_manual(values = colors_represor_activator,  aesthetics = "colour")
    print(myplot)
    dev.off()

}

