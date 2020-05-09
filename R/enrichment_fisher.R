#' evaluates KO enrichment using the fisher test
#'
#' @description Takes a \code{data.frame} and a vector with column names
#' contained in the data.frame. Performs the fisher test to evaluate enrichement per KO
#' per phylogenetic group from selected phylogeny.
#'
#' @param x data frame where the test will be applied.
#' @param replace_by Replace the Inf values in the odd.ratio matrix by a value.
#' @param column_names Vector with column names to include in the test
#' @param phylogeny Vector of phylogenetic groups or rownames to include in the test
#'
#' @return a list with two matrixes: p.value and odd.ratio.
#' @export
#'
#' @examples
#' my_data <- erba::sigma_filtered
#' fisher_evaluation <- enrichment_fisher(sigma_filtered, kos_sigma)
#' fisher_evaluation <- enrichment_fisher(sigma_filtered, kos_sigma, replace_by  = 100)
enrichment_fisher <- function(x, column_names, replace_by = NULL, phylogeny = selected_phylogeny) {

  fisher.pvalue.table <- data.frame()
  fisher.odd.table <- data.frame()

  for (phylum in phylogeny) {
    for (column in column_names) {
      col_i <- sum(x[x$phylum == phylum, column])  # freq of the ko/cog in the phylogenetic group of interest
      col_rest_i <- sum(x[x$phylum == phylum,"total"]) - col_i # total kos/cogs in the phylogenetic group of interest
      col_total <- sum(x[,column]) - col_i # total of the ko/cog in all phyla
      total_total <- sum(x$total) - col_total - col_i # total of all kos/cogs in all phyla

      my.matrix <- matrix(c(col_i,col_total, col_rest_i,total_total), nrow = 2) # builds the contingency table as matrix

      fisher.result <- fisher.test(my.matrix) # fisher test
      fisher.pvalue.table[phylum,column] <- fisher.result$p.value # writes result
      fisher.odd.table[phylum,column] <- fisher.result$estimate # writes result
    }
  }

  # correction for the multi sample analysis
  fisher.pvalue.matrix <- as.matrix(fisher.pvalue.table)
  corrected.pvalue <- p.adjust(as.vector(fisher.pvalue.matrix), method = "fdr" )
  corrected.pvalue.matrix <- matrix(corrected.pvalue, nrow = length(phylogeny), dimnames = dimnames(fisher.pvalue.matrix) )

  fisher.odd.matrix <- as.matrix(fisher.odd.table) # convert to matrix

  if (!is.null(replace_by)) {
    if ( is.numeric(replace_by) & replace_by >= 0 ) {
      fisher.odd.matrix[is.infinite(fisher.odd.matrix)] <-  replace_by } else
      {warning (" Argument 'replace_by' should be a numeric value equals or greater than zero, default will be used", call. = FALSE)}
  }

  fisher.result <- list("p.value" = corrected.pvalue.matrix,
                        "odd.ratio" = fisher.odd.matrix)
  return(fisher.result)


}
