# preload this file to
# 1. compile style.scss
# 2. use data in data-raw/
# 3. finally, devtools::load_all()

# in dir "personr"
# source("preload.R")


# compile style.scss
system("sass style.scss inst/app/www/style.css")


# use data in data-raw/
source("data-raw/test.R", chdir = TRUE)
source("data-raw/norm.R", chdir = TRUE)

usethis::use_data(
  test, score, score.numeric, score.data.frame, norm, plots,
  internal = TRUE,
  overwrite = TRUE
)

rm(list = ls())


devtools::load_all()
launch_test("~/Desktop/")
