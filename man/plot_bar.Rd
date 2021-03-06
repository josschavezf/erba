% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_bar.R
\name{plot_bar}
\alias{plot_bar}
\title{plot_bar}
\usage{
plot_bar(data, filename, title, add.legend = TRUE, legend.title = "")
}
\arguments{
\item{data}{A data.frame object}

\item{filename}{file name with .tiff extension}

\item{title}{plot name inside " "}

\item{addLegend}{default = TRUE}
}
\description{
plot total regulators versus ORFs per genome
}
\examples{
plot_bar(data_kos_sigma,
filename = "bar_example.tiff",
title = "bar distribution")

plot_bar(data_kos_sigma,
filename = "bar_example.tiff",
title = "bar distribution",
addLegend = FALSE)
}
