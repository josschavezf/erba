#' Makes heatmap with dendrogram clustering
#'
#' @param x A matrix object with numeric values
#' @param file.1 file name .png for image with default size
#' @param file.2 file name .png for image with augmented size
#' @param my.limits Vector of two values with limits for color scale
#'
#' @return Two .png files with heatmap and dendrogram clustering
#' @export
#'
#' @examples
#' enrichment_heatmap_dendrogram(fisher_sigma[[2]], "sigma1.png", "sigma2.png", c(0,100))

enrichment_heatmap_dendrogram <- function(x, file.1, file.2, my.limits ) {
  #dendrogram data
  dd.col <- as.dendrogram(hclust(dist(x)))
  dd.row <- as.dendrogram(hclust(dist(t(x))))
  dx <- ggdendro::dendro_data(dd.row)
  dy <- ggdendro::dendro_data(dd.col)

  # helper function for creating dendrograms
  ggdend <- function(df) {
    ggplot() +
      geom_segment(data = df, aes(x=x, y=y, xend=xend, yend=yend)) +
      labs(x = "", y = "") + theme_classic() +
      theme(axis.text = element_blank(),
            axis.ticks = element_blank(),
            axis.line = element_blank())
  }

  # x/y dendrograms
  px <- ggdend(dx$segments)
  py <- ggdend(dy$segments) + coord_flip()

  # heatmap
  col.ord <- order.dendrogram(dd.col)
  row.ord <- order.dendrogram(dd.row)
  xx <- x[col.ord, row.ord]
  xx_names <- attr(xx, "dimnames")
  df <- as.data.frame(xx)
  colnames(df) <- xx_names[[2]]
  df$group <- xx_names[[1]]
  df$group <- with(df, factor(group, levels=group, ordered=TRUE))
  mdf <- reshape2::melt(df, id.vars="group")

  p <- ggplot(mdf, aes(x = variable, y = group)) + geom_tile(aes(fill = value)) +
    scale_fill_gradient(low = "white", high = "#013047", na.value = "#013047", limits = my.limits) +
                          theme(
                            axis.text.x = element_text(angle = 90, face = "bold", size = 8),
                            axis.text.y = element_text(face = "bold"))

  # hide axis ticks and grid lines
  eaxis <- list(
    showticklabels = FALSE,
    showgrid = FALSE,
    zeroline = FALSE
  )

  # export image
  pp <- plotly::subplot(px, ggplot(), p, py, nrows = 2, margin = 0.001, heights = c(0.1,0.9), widths = c(0.9,0.1))
  plotly::plotly_IMAGE(pp, format = "png", out_file = file.1)
  plotly::plotly_IMAGE(pp, format = "png", out_file = file.2,  width = 2400, height = 1400)

}
