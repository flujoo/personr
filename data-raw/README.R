# source current file to use all data in data-raw/
# source("data-raw/README.R", chdir = TRUE)

source("test.R", chdir = TRUE)
source("norm.R", chdir = TRUE)

usethis::use_data(test, norm, internal = TRUE, overwrite = TRUE)
