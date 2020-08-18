#' slope
#' @description Get slope of points distribution with linear regression model
#' @param x x axis
#' @param y y axis
#' @export
slope <- function(x, y){
  mean_x <- mean(x)
  mean_y <- mean(y)
  nom <- sum((x - mean_x)*(y-mean_y))
  denom <- sum((x - mean_x)^2)
  m <- nom / denom
  return(m)
}

#' intercept
#' @description Get intercept value of points distribution with linear regression model
#' @param x x axis
#' @param y y axis
#' @param m slope of distribution
#' @export
intercept <- function(x, y, m){
  b <- mean(y) - (m * mean(x))
  return(b)
}

#' get_correlation
#' @description Get correlation index of regulator's total number versus ORFs number per
#' organism. Shows correlation for each phylogenetic group.
#'
#' @param data A `data.frame`
#' @param y y-axis name
#' @param x x-axis name
#'
#' @importFrom dplyr as_tibble select summarise %>%
#'
#' @examples
#' get_correlation(total_cogs, "Transcription Factors", "ORFs(X100)")
#'
#' @export
get_correlation <- function(data, x, y){
  as_tibble(data) %>%
    group_by(phylum) %>%
    select(x = x, y = y) %>%
    summarise(cor = round(cor(y, x),2) )
}

#' get_linear_coefficients
#' @description Get intercept and slope from the data's linear model
#' @param x data frame to calculate regression model coefficients
#' @importFrom dplyr %>%
#' @export
get_linear_coefficients <- function(x){
  for (i in selected_phylogeny) {
    myTable <- x %>%
      filter(phylum == i) %>%
      select(total, ORFs)
    my_model <- lm(total~ORFs, data = myTable)
    print(i)
    print(coef(my_model))
  }
}
