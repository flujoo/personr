# make the package a Shiny app

# wrap scale up in HTML
htmlize_scale <- function(statement_number) {
  # scale labels
  sls <- test$scale$label
  # scale values
  svs <- test$scale$value
  # scale length
  n <- nrow(test$scale)
  # wrap scale
  s_html <- list()
  for (i in 1:n) {
    s_i <- shiny::tags$li(
      # input element
      shiny::tags$input(
        type = "radio",
        id = paste("value", i, sep = "_"),
        name = paste("item", statement_number, sep = "_"),
        value = svs[i]
      ),
      # label element
      shiny::tags$label(sls[i], "for" = paste("value", i, sep = "_"))
    )
    s_html[[i]] <- s_i
  }
  # ordered list element
  shiny::tags$ol(s_html, class = "scale")
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
      # wrap statement
      shiny::p(ss[i], class = "statement"),
      # wrap scale
      htmlize_scale(i),
      class = "item",
      id = paste("item", i, sep = "_")
    )
    items[[i]] <- item_i
  }
  shiny::tags$main(items)
}


# launch Shiny app to start personality test
launch_test <- function() {
  # generate CSS file
  path_scss <- system.file("test", "style_test.scss",
                           package = "personr")
  path_css <- paste(
    system.file("test", "www", package = "personr"),
    "style_test.css",
    sep = "/"
  )
  sass::sass(sass::sass_file(path_scss), output = path_css)

  path <- system.file("test", package = "personr")
  shiny::runApp(appDir = path, launch.browser = TRUE)
}
