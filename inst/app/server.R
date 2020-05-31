function(input, output, session) {
  # store responses
  vs <- shiny::reactiveValues(rs = integer(50))
  shiny::observe({
    for (i in 1:50) {
      r_n <- paste("item", i, sep = "_")
      r <- input[[r_n]]
      if (!is.null(r)) {
        vs$rs[i] <- as.integer(r)
      }
    }
  })

  # generate report when button pressed
  shiny::observeEvent(input$submit, {
    personr_globals$responses <<- vs$rs
    report(personr_globals$responses, personr_globals$wd)
  })
}
