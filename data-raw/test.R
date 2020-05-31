# personality test used in the package
# refs:
# https://openpsychometrics.org/tests/IPIP-BFFM/
# https://ipip.ori.org/new_ipip-50-item-scale.htm

test <- list()

test$title <- "Test Your Personality"

test$instruction <- paste(
  "Describe yourself as you generally are now,",
  "not as you wish to be in the future.",
  "Describe yourself as you honestly see yourself,",
  "in relation to other people you know of the same sex as you are,",
  "and roughly your same age.",
  "So that you can describe yourself in an honest manner,",
  "your responses will be kept in absolute confidence.",
  "Indicate for each statement whether it is 1. Very Inaccurate,",
  "2. Moderately Inaccurate, 3. Neither Accurate Nor Inaccurate,",
  "4. Moderately Accurate, or 5. Very Accurate as a description of you."
)

test$statements <- trimws(readLines("statements.md"))

test$scale <- data.frame(
  label = c(
    "Very Inaccurate",
    "Moderately Inaccurate",
    "Neither Accurate Nor Inaccurate",
    "Moderately Accurate",
    "Very Accurate"
  ),
  value = 1:5
)

# negatively worded statement numbers
test$reversed <- c(
  2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26,
  28, 29, 30, 32, 34, 36, 38, 39, 44, 46, 49
)

# statement numbers under each factor
test$factors <- list(
  Extraversion = c(1, 6, 11, 16, 21, 26, 31, 36, 41, 46),
  Agreeableness = c(2, 7, 12, 17, 22, 27, 32, 37, 42, 47),
  Conscientiousness = c(3, 8, 13, 18, 23, 28, 33, 38, 43, 48),
  "Emotional Stability" = c(4, 9, 14, 19, 24, 29, 34, 39, 44, 49),
  "Intellect/Imagination" = c(5, 10, 15, 20, 25, 30, 35, 40, 45, 50)
)


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
