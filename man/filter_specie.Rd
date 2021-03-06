% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/filter_specie.R
\name{filter_specie}
\alias{filter_specie}
\title{select the organism with bigger genome}
\usage{
filter_specie(x)
}
\arguments{
\item{x}{data.frame to filtering}
}
\value{
data.frame of the organisms with biggest genomes and their quantification of KOs per genome.
}
\description{
For each specie name allocated in V4, selects the organism with the biggest genome, given by the number of ORFs in V2.
}
\examples{
# function applyied to one data frame
filter_specie(list_data_sigma[[1]])
}
