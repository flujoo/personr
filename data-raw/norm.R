# normative group data to interpret score
# raw data "BIG5" downloaded from:
# https://openpsychometrics.org/_rawdata/


# correct response-columns' order
response_cols <- unlist(lapply(
  1:10,
  function(i) { paste(c("E", "A", "C", "N", "O"), i, sep = "") }
))

# keep only some columns
cols <- c(names(test$factors), "race", "age", "gender", "country")


# import normative group data
norm <- read_delim("BIG5/data.csv", delim = "\t") %>%
  select(one_of(response_cols), everything()) %>%
  as.data.frame %>%
  score %>%
  .[, cols]


# plots
plots <- list()

# https://github.com/tidyverse/ggplot2/issues/
# 2447#issuecomment-364955240
for (f in names(test$factors)) {
  f_sym <- sym(f)
  plots[[f]] <- ggplot() +
    geom_density(data = norm, aes(!!f_sym),
                 fill = "#3484bc", alpha = 0.4)
}
