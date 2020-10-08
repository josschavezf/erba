#' plot_exception
#'
#' @description plot total regulators versus ORFs per genome with double distribution
#' @param x A data.frame object
#' @param exception_group phylum to be used as exception
#' @param filename file name with .tiff extension
#' @param title plot name inside " "
#' @param ylab ylab name inside " "
#' @param ymax A number setting the ylab superior limit.
#' @examples
#' plot_exception(data_riboswitch, filename = "riboswitch.tiff",
#'                 title = "Riboswitches",
#'                 ylab = "Riboswitches per genome",
#'                 ymax = 80,
#'                 exception_group = "Firmicutes" )

#' @export
plot_exception <- function (x, filename =  "figure.tiff", title = "", ylab = "", ymax = 120, exception_group = NULL) {
    exception_table <- x %>% filter(phylum == exception_group)
    rest_table <- x %>% filter(!phylum == exception_group)
    myplot <- ggplot(x, aes(x = CDS, y = total)) +
      geom_point(size = 0.5) +
      ylim(0, ymax) +
      xlim(0,100) +
      geom_abline(aes(intercept = intercept(exception_table$CDS, exception_table$total,
                                            slope(exception_table$CDS,exception_table$total)),
                      slope = slope(exception_table$CDS,exception_table$total)), color = "blue") +
      geom_abline(aes(intercept = intercept(rest_table$CDS, rest_table$total,
                                            slope(rest_table$CDS, rest_table$total)),
                      slope = slope(rest_table$CDS, rest_table$total)),color = "red", size = 0.5) +
      ggtitle(title) +
      labs(x= "CDS (x 100)", y = ylab) +
      theme(panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            panel.background = element_blank(),
            plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
            axis.title = element_text(size = 14, face="bold"),
            axis.text = element_text(size = 12, face = "bold"),
            axis.ticks = element_line(size = 1.2, lineend = 2),
            axis.line = element_line(colour = "black", size=1.2))
    ggsave(filename, plot = myplot, device = "tiff",
           width = 7, height = 5, units = "cm", dpi = 300,  scale = 2)

}
