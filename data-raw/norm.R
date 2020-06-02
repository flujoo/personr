# normative group data to interpret score
# raw data "BIG5" downloaded from:
# https://openpsychometrics.org/_rawdata/


library(magrittr)


# correct response-columns' order
response_cols <- unlist(lapply(
  1:10,
  function(i) { paste(c("E", "A", "C", "N", "O"), i, sep = "") }
))

# keep only some columns
cols <- c(names(test$factors), "race", "age", "gender", "country")


# import normative group data
norm <- readr::read_delim("BIG5/data.csv", delim = "\t") %>%
  dplyr::select(dplyr::one_of(response_cols), dplyr::everything()) %>%
  as.data.frame %>%
  score %>%
  .[, cols]
