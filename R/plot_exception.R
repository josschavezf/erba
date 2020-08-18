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
    print(exception_group)
    print(slope(exception_table$ORFs,exception_table$total))
    print("Rest")
    print(slope(rest_table$ORFs, rest_table$total))
    tiff(filename = filename, width = 1234, height = 880, units = 'px', res = 100)
    myplot <- ggplot(x, aes(x = ORFs, y = total)) +
      geom_point() +
      ylim(0, ymax) +
      xlim(0,100) +
      geom_abline(aes(intercept = intercept(exception_table$ORFs, exception_table$total,
                                            slope(exception_table$ORFs,exception_table$total)),
                      slope = slope(exception_table$ORFs,exception_table$total)), color = "blue") +
      geom_abline(aes(intercept = intercept(rest_table$ORFs, rest_table$total,
                                            slope(rest_table$ORFs, rest_table$total)),
                      slope = slope(rest_table$ORFs, rest_table$total)),color = "red", size = 1) +
      ggtitle(title) +
      labs(x= "ORFs (x 100)", y = ylab) +
      theme(panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            panel.background = element_blank(),
            plot.title = element_text(hjust = 0.5, size = 28, face = "bold"),
            axis.title = element_text(size = 26, face="bold"),
            axis.text = element_text(size = 22, face = "bold"),
            axis.ticks = element_line(size = 1.5, lineend = 2),
            axis.line = element_line(colour = "black", size=1.5))
    print(myplot)
    dev.off()
}
