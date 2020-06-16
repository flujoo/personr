# Shiny app for generating personality test


# global variables
personr_globals <- new.env()

# working directory
personr_globals$wd <- ""


# wrap scale up in HTML
htmlize_scale <- function(statement_number) {
  # scale
  s <- test$scale
  # scale length
  n <- nrow(test$scale)
  # statements
  ss <- test$statements

  choices <- list()
  for (i in 1:n) {
    choices[[s$label[i]]] = s$value[i]
  }
  id <- paste("item", statement_number, sep = "_")
  label <- ss[statement_number]

  shiny::radioButtons(
    inputId = id,
    label = label,
    choices = choices,
    selected = FALSE
  )
}


# wrap test items up in HTML
htmlize_items <- function() {
  # all statements
  ss <- test$statements
  # total statement number
  n <- length(ss)
  # wrapped up items
  items <- list()
  for (i in 1:n) {
    item_i <- shiny::div(
      # wrap scale
      htmlize_scale(i),
      class = "item",
      id = paste("item", i, sep = "_")
    )
    items[[i]] <- item_i
  }
  shiny::tags$main(items)
}


# https://stackoverflow.com/questions/37830819/
# developing-shiny-app-as-a-package-and-deploying-it-to-shiny-server

#' @title Launch a Personality Test
#'
#' @description Launch a personality test and get a report.
#'
#' @param path A string to set where to store your test report.
#'
#' @return No return value, a Shiny app is launched, and two files
#' named "report.Rmd" and "report.html" generates in your path
#' after you click the "Submit" button in the app.
#'
#' @details The test is called "Big Five Personality Test" and is from
#' \url{https://openpsychometrics.org/tests/IPIP-BFFM/}.
#'
#' After you finish and submit your responses,
#' a report will generate in your path.
#'
#' @seealso \code{\link{report}} for generating report
#' without calling \code{launch_test}.
#'
#' @examples
#' if (interactive()) {
#'   launch_test(path = tempdir())
#' }
#'
#' @export
launch_test <- function(path) {
  # set working directory
  path <- normalizePath(path)
  assign('wd', path, personr_globals)
  shiny::runApp(
    appDir = system.file("app", package = "personr"),
    launch.browser = TRUE
  )
}
