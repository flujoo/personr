# generate report
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
  browseURL(path_html)
}
