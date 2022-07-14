source("data.R")
# in data.R
# default_prop <- list(
#   US = 50,
#   Germany = 50
# )

# Functions

function(input, output, session) {
  # Update default prop
  observeEvent(
    input$country,
    {
      updateSliderInput(
        session, "prop",
        value = default_prop[[input$country]]
      )
    }
  )

  # Table Result
  dat <- data.frame(date=seq.Date(Sys.Date(),by=1,length.out=5),
                  temp = runif(5))
  output$res_table <- renderDataTable({dat})

  # Figure plot
  ggplot() +
    geom_point(aes(x = 1, y = 1)) +
    NULL -> p
  output$res_plot <- renderPlot({p})
}
