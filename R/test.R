# score test
score <- function(responses) {
  # reversed item numbers
  r <- test$reversed
  # scale
  s <- test$scale$value
  # factors
  fs <- test$factors

  for (i in 1:length(fs)) {
    # factor name
    f <- names(fs)[i]
    # item numbers
    ns <- fs[[i]]
    # reversed item numbers
    rns <- ns[ns %in% r]
    # normal item numbers
    nns <- ns[!ns %in% r]
    # reverse and score
    responses[, f] <- rowMeans(
      cbind(responses[, nns], (max(s) + min(s) - responses[, rns])),
      na.rm = TRUE
    )
  }

  # return
  n <- ncol(responses)
  responses[, (n - 4):n]
}
