#' @title Generate a Personality Test Report
#'
#' @description Generate a personality test report without launching the test.
#'
#' @param responses A integer vector to represent
#' your answers to the questions in the test.
#' @param path A string to set where to store your test report.
#'
#' @details \code{report} will be automatically called after
#' you call \code{launch_test} and submit your responses. Two files
#' named "report.Rmd" and "report.html" will generate in your path.
#'
#' The report summaries your test results, and compares them to other people's
#' to tell you what the results mean.
#'
#' @seealso \code{\link{launch_test}} to launch the personality test.
#'
#' @export
report <- function(responses, path) {
  # path to style.css
  path_style <- system.file("app", "www", "style.css",
                            package = "personr")
  # path to report template
  path_report <- system.file("report.Rmd", package = "personr")

  # path to rendered report.Rmd
  path_rmd <- paste(path, "report.Rmd", sep = "/")
  # path to rendered report.html
  path_html <- paste(path, "report.html", sep = "/")

  # load report template
  report_template <- readLines(path_report)
  # render template with
  render_with <- list(
    path_style = path_style
  )
  # render template
  writeLines(
    whisker::whisker.render(report_template, render_with),
    path_rmd
  )
  # render rmd
  rmarkdown::render(path_rmd, output_dir = path)
  # open
  utils::browseURL(path_html)
}
