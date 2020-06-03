# preload this file to
# 1. compile style.scss
# 2. use data in data-raw/

# in dir "personr"
# source("preload.R")

# compile style.scss
system("sass style.scss inst/app/www/style.css")

# use functions from personr to process data
# but remove old data first to avoid errors
file.remove("R/sysdata.rda")
devtools::load_all()

# use data in data-raw/
source("data-raw/test.R", chdir = TRUE)
source("data-raw/norm.R", chdir = TRUE)
usethis::use_data(test, norm, internal = TRUE, overwrite = TRUE)
rm(list = ls())
