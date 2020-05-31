# Shiny app for generating personality test


# global variables
personr_globals <- new.env()

# working directory
personr_globals$wd <- getwd()


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


# launch Shiny app to start personality test
launch_test <- function(path = getwd()) {
  # set working directory
  personr_globals$wd <<- path
  shiny::runApp(
    appDir = system.file("app", package = "personr"),
    launch.browser = TRUE
  )
}
