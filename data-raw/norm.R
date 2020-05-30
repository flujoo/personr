# normative group data to interpret score
# raw data "BIG5" downloaded from:
# https://openpsychometrics.org/_rawdata/

# import normative group data
norm <- readr::read_delim("BIG5/data.csv", delim = "\t")

# correct response-columns' order
response_cols <- unlist(lapply(
  1:10,
  function(i) { paste(c("E", "A", "C", "N", "O"), i, sep = "") }
))

norm <- as.data.frame(dplyr::select(
  norm, dplyr::one_of(response_cols), dplyr::everything()))
