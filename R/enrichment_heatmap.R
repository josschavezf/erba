#' make enrichment heatmap
#'
#' @description Takes the odd.ratio matrix from \link{enrichment_fisher} test. Odd.ratio values are plotted as log(odd.ratio).
#'
#' @param x odd.matrix from \link{enrichment_fisher}
#' @param tiff_name file name with .tiff extension
#' @param my.limit limits for color gradient
#' @param breaks a vector with breaks for color gradient
#'
#' @return heatmap exported as tiff file. Odd.ratio values are transformed as log(odd.ratio).
#' @export
#'
#' @examples
#' fisher_sigma <- erba::enrichment_fisher(sigma_filtered, kos_sigma, replace_by = 100)
#' my.odd.matrix <- fisher_sigma[[2]]
#' enrichment_heatmap(my.odd.matrix, "heatmap.tiff", my.limit = c(-10,10), breaks = seq(from = -10, to = 10, by = 2))
enrichment_heatmap <- function(x, tiff_name, my.limit, breaks) {

  # set colors for gradient
  my.colors = rev(c("#700c0c", "#a61212",
                "#cf1717", "#e84343",
                "#de6f6f", "#e39f9f",
                "#ebc0c0", "#f5dfdf",
                "#f0e9e9", "white", "#cae8ed",
                "#98dfeb", "#5ed2e6",
                "#4aa4d9", "#2e9bdb",
                "#098ddb", "#036199",
                "#014d7a", "#093d5c", "#081b38"))

  # set colors for phylogenetic group names
  myPalette <- colors_groups
  names(myPalette) <- selected_phylogeny

  # prepare data
  my_table <- as.data.frame(x) # convert to data.frame
  my_table$group <- rownames(my_table) # add variable 'group'
  my_new_table <- melt(my_table, by = "group") # melt by group
  my_new_table$value <- my_new_table$value + 1e-10 # avoid zeros

  # export heatmap
  tiff(tiff_name, width = 2400, height = 1400, units = "px", res = 100)

  my.plot <- ggplot(my_new_table, aes(x= my_new_table$group, y= my_new_table$variable,fill= log(my_new_table$value)))  +
    geom_tile() +
    scale_fill_gradientn(colours =  my.colors,
                         limits = my.limit,
                         guide = "colourbar",
                         oob = scales::squish,
                         breaks = breaks) +
    theme(legend.title = element_blank(),
          legend.text = element_text(size = 18, face = "bold", hjust = 0.5),
          legend.key.size = unit(2,"cm"),
          axis.title.x = element_blank(),
          axis.title.y = element_blank(),
          axis.text.x = element_text(colour=myPalette[my_new_table$group], size = 22, angle = 90, face = "bold"),
          axis.text.y = element_text(size = 20, face = "bold"),
          panel.background = element_blank()) +
    scale_x_discrete(position = "top",expand = c(0, 0)) +
    scale_y_discrete(limits = rev(levels(my_new_table$variable)), expand = c(0,0))
  print(my.plot)
  dev.off()
}
