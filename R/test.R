# score test
score <- function(responses) UseMethod("score", responses)


# score single subject's outcome
score.numeric <- function(responses) {
  # score
  s <- data.frame(
    factor = names(test$factors),
    score = double(5)
  )
  # factors
  fs <- test$factors
  # reversed item numbers
  r <- test$reversed
  # scale
  scl <- test$scale$value

  for (i in 1:length(fs)) {
    f <- names(fs)[i]
    ns <- fs[[f]]
    # reversed item numbers
    rns <- ns[ns %in% r]
    # normal item numbers
    nns <- ns[!(ns %in% r)]
    m <- mean(
      c(
        responses[nns],
        # reverse score
        max(scl) + min(scl) - responses[rns]
      ),
      na.rm = TRUE
    )
    s[s$factor == f, "score"] <- m
  }

  s
}


# score norm data
score.data.frame <- function(responses) {
  # factors
  fs <- test$factors
  # reversed item numbers
  r <- test$reversed
  # scale
  scl <- test$scale$value

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
      cbind(
        responses[, nns],
        # reverse score
        max(scl) + min(scl) - responses[, rns]
      ),
      na.rm = TRUE
    )
  }

  responses
}
