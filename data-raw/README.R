# source current file to use all data in data-raw/
# source("data-raw/README.R", chdir = TRUE)

library(readr)
library(dplyr)
library(ggplot2)
library(magrittr)

source("test.R", chdir = TRUE)
source("norm.R", chdir = TRUE)

usethis::use_data(
  test, score, norm, plots,
  internal = TRUE,
  overwrite = TRUE
)

rm(list = ls())
detach("package:readr", unload = TRUE)
detach("package:dplyr", unload = TRUE)
detach("package:ggplot2", unload = TRUE)
detach("package:magrittr", unload = TRUE)
