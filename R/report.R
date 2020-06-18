theme <- ggplot2::theme(
  panel.background = ggplot2::element_rect(fill = "#faf7f2"),
  axis.line = ggplot2::element_line(colour = "#a59583"),
  text = ggplot2::element_text(colour = "#766c60")
)


plot_score <- function(score_) {
  ggplot2::ggplot(score_, ggplot2::aes(factor, score, fill = factor)) +
    ggplot2::geom_col() +
    ggplot2::coord_cartesian(ylim = c(1,5), expand = FALSE) +
    ggplot2::geom_text(
      ggplot2::aes(label = score), color = "white", size = 5,
      position = ggplot2::position_nudge(y = -0.3)) +
    ggplot2::scale_fill_manual(
      "factor",
      # color scheme from ggthemr::ggthemr('dust')
      values = c(
        "Agreeableness" = "#db735c",
        "Conscientiousness" = "#efa86e",
        "Emotional Stability" = "#9a8a76",
        "Extroversion" = "#f3c57b",
        "Intellect/Imagination" = "#7a6752"
      )
    ) +
    theme
}


# plot score against norm data
interpret <- function(score_, factor_) {
  # all factor names
  fs <- names(test$factors)
  # color scheme from ggthemr::ggthemr('dust')
  cs <- list(
    "Agreeableness" = "#db735c",
    "Conscientiousness" = "#efa86e",
    "Emotional Stability" = "#9a8a76",
    "Extroversion" = "#f3c57b",
    "Intellect/Imagination" = "#7a6752"
  )
  # color for factor_
  c_ <- cs[[factor_]]
  # used in aes
  f_sym <- rlang::sym(factor_)
  # score for factor_
  s <- score_[score_$factor == factor_, "score"]
  # quantile of score for factor_
  q <- stats::ecdf(norm[[factor_]])(s)
  q <- paste(round(q*100, 1), "%", sep = "")

  ggplot2::ggplot() +
    ggplot2::geom_density(
      data = norm, ggplot2::aes(!!f_sym),
      fill = c_, alpha = 0.4, color = c_) +
    ggplot2::geom_vline(xintercept = s, color = c_, size = 1) +
    # https://stats.stackexchange.com/questions/50080/
    # estimate-quantile-of-value-in-a-vector
    ggplot2::annotate("text", x = (s - 0.3), y = 0.25,
                      label = q, size = 5, color = "#766c60") +
    theme
}


#' @title Generate a Personality Test Report
#'
#' @description Generate a personality test report without launching the test.
#'
#' @param responses A numeric vector to represent
#' your answers to the questions in the test.
#' @param path A string to set where to store your test report.
#'
#' @return No return value, two files
#' named "report.Rmd" and "report.html" generates in your path.
#'
#' @details \code{report} will be automatically called after
#' you call \code{launch_test} and submit your responses.
#'
#' The report summaries your test results, and compares them to other people's
#' to tell you what the results mean.
#'
#' @seealso \code{\link{launch_test}} to launch the personality test.
#'
#' @examples
#'
#' if (interactive()) {
#'   # a numeric vector representing your responses to the test
#'   rs <- rep(1, 50)
#'
#'   # generate report
#'   path <- tempdir()
#'   report(rs, path)
#' }
#'
#' @export
report <- function(responses, path) {
  path <- normalizePath(path)
  # path to style.css
  path_style <- system.file("app", "www", "style.css",
                            package = "personr")
  # path to report template
  path_report <- system.file("report.Rmd", package = "personr")

  # path to rendered report.Rmd
  path_rmd <- file.path(path, "report.Rmd")
  # path to rendered report.html
  path_html <- file.path(path, "report.html")

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
  rmarkdown::render(path_rmd, output_dir = path, quiet = TRUE)
  # open
  utils::browseURL(path_html)
}
