#' Calculating Normal Score and Standard(Z) Score
#'
#' @param data Numeric vector. The standard score and normal score are calculated on this argument.
#' @param ties one of "average", "random", "first", and "last". The method to deal with the ties in data. Default is "average"
#'
#' @return data.frame with calculated normal score and standard score of the given data.
#' @export
#'
#' @examples
#' data<-rnorm(30)
#' normal_scores(data = data, ties = "average")
normal_scores <- function (data, ties = "average") {
  if (length(data) == 0 || length(stats::na.omit(data)) == 0) {
    stop("At least one non-missing value is required")
  }
  data = stats::na.omit(data)
  length = as.numeric(length(data))
  if (!(ties %in% c("average","first","last","random"))) {
    warning("The method you chose for breaking ties is not supported. Average method would be used instead.")
    ties = "average"
  }
  a = 0.5
  if (length <= 10) a = 0.375
  normal_score = stats::qnorm((rank(data,ties.method = ties) - a) / (length + 1 - 2 * a))
  standard_score = (data - mean(data)) / stats::sd(data)
  data.frame(normal_score,standard_score)
}
