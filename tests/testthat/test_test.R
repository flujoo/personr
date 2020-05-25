library(personr)


test_that("reversed item numbers", {
  out <- test$reversed
  expected <- c(
    seq(2, 26, 2),
    28, 29, 30, 32, 34, 36, 38, 39, 44, 46, 49
  )
  expect_equal(out, expected)
})


test_that("item numbers under factors", {
  ns <- seq(1, length(test$statements), 5)
  for (i in ns) {
    expect_true(i %in% test$factors$Extraversion)
    expect_true((i + 1) %in% test$factors$Agreeableness)
    expect_true((i + 2) %in% test$factors$Conscientiousness)
    expect_true((i + 3) %in% test$factors$`Emotional Stability`)
    expect_true((i + 4) %in% test$factors$`Intellect/Imagination`)
  }
})


test_that("reverse score", {
  s <- test$scale$value
  out <- test$reverse(s)
  expected <- rev(s)
  expect_equal(out, expected)
})


test_that("score test", {
  rs <- rep(1, 50)
  out <- test$score(rs)
  # according to https://openpsychometrics.org/tests/IPIP-BFFM/
  expected <- list(
    "Extraversion" = 3,
    "Agreeableness" = 2.6,
    "Conscientiousness" = 2.6,
    "Emotional Stability" = 4.2,
    "Intellect/Imagination" = 2.2
  )
  expect_equal(out, expected)
})
