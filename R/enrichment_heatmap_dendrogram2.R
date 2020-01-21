#' Makes heatmap with dendrogram clustering
#'
#' @param x A matrix object with numeric values
#' @param my.limits Vector of two values with limits for color scale
#' @param file output file name
#' @param fill_by_log Logical value indicating whether heatmap is filled by a new value given by: enrichment value + 1e-5.
#' @param return.x Logical value indicating whether the function returns axis.x clustering
#' @param return.y Logical value indicating whether the function returns axis.y clustering
#'
#' @return A .png file with heatmap and dendrogram clustering. If return.x/return.y = TRUE, returns a list with clustering data.
#' @export
#'
#' @examples
#' enrichment_heatmap_dendrogram2(fisher_sigma[[2]], file = "sigma.png", my.limits  = c(-3,3))
#' enrichment_heatmap_dendrogram2((fisher_sigma[[2]] + 1e-3), file = "sigma.png", my.limits  = c(-3,3), fill_by_log = FALSE)


enrichment_heatmap_dendrogram2 <- function(x, file, my.limits, fill_by_log = TRUE, return.x = FALSE, return.y = FALSE, col.order = FALSE, row.order = FALSE) {
  #dendrogram data
  dd.col <- as.dendrogram(hclust(dist(x)))
  dd.row <- as.dendrogram(hclust(dist(t(x))))
  if (!is.logical(col.order) || col.order) { dd.col <-  col.order}
  if (!is.logical(row.order) || row.order) { dd.row <- row.order}
  dx <- ggdendro::dendro_data(dd.row)
  dy <- ggdendro::dendro_data(dd.col)

  return_list <- list()
  if (return.x || return.y) {
    if (return.x && return.y) {
      return_list[1] <- dd.row
      return_list[2] <- dd.col
    } else {ifelse (return.x, return_list[[1]] <- dd.row, return_list[[1]] <- dd.col)}
    return(return_list)}

  # helper function for creating dendrograms
  ggdend <- function(df) {
    ggplot() +
      geom_segment(data = df, aes(x=x, y=y, xend=xend, yend=yend)) +
      labs(x = "", y = "") +
      theme(axis.text = element_blank(),
            axis.ticks = element_blank(),
            axis.line = element_blank(),
            panel.grid = element_blank(),
            panel.background = element_rect(fill = "white")
            )
  }

  # x/y dendrograms
  px <- ggdend(dx$segments)
  py <- ggdend(dy$segments) + coord_flip() + scale_y_reverse()

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


  if (fill_by_log == TRUE) {histogram_param = geom_tile(aes(fill = log10(value+1e-5)))}
  else {histogram_param = geom_tile(aes(fill = value))}
  p <- ggplot(mdf, aes(x = variable, y = group)) + histogram_param +
    scale_fill_gradient2(low = "blue", mid= "white", high = "red", midpoint = 0, na.value = "red", limits = my.limits, oob = scales::squish) +
    theme(
      axis.text.x = element_text(angle = 90, face = "bold", size = 8),
      axis.text.y = element_text(face = "bold", size = 12, hjust = 0.1 ),
      axis.ticks = element_blank(),
      axis.title = element_blank(),
      legend.title = element_blank(),
      panel.background = element_rect(fill = "white"))

  # export image
#  pp <- plotly::subplot(px, ggplot(), p, py, nrows = 2, margin = 0.001, heights = c(0.1,0.9), widths = c(0.9,0.1))
  pp <- plotly::subplot(ggplot(),ggplot(),px, py,ggplot(), p,  nrows = 2, margin = 0.02,  heights = c(0.1,0.9), widths = c(0.1,0.1,0.8), which_layout = 6)
  plotly::plotly_IMAGE(pp, format = "png", out_file = file, width = 1200)
}
