#' get_kos
#'
#' @description Imports KO names from local file
#' @param regulator Class of regulator: "sigma" for sigma factors or "tf" for transcription factors
#' @export
get_kos <- function(regulator) {
  if (regulator == "sigma") { file <- "kos_sigma_factor"}
  if (regulator == "tf") { file <- "kos_transcription_factor"}

  kos_data <- read.delim(file, header = FALSE)
  kos <- as.vector(kos_data$V1)
  return(kos)
}
