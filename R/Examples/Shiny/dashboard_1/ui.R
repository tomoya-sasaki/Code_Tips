library(shiny)
library(shinydashboard)
library(tidyverse)
source("data.R")

# shiny::runApp('./')

dashboardPage(
  dashboardHeader(
    title = "Example",
    titleWidth = 300
  ),
  dashboardSidebar(disable = TRUE),
  dashboardBody(
    fluidRow(
    # Column 1: Parameters
    column(width = 3,
      box(width = NULL,
        # Country
        selectInput(
          "country",
          "Country",
          choices = c("US", "Germany")
        ),
        # Proportion
        sliderInput(
          "prop",
          "Proportion",
          min = 0, max = 100, value = default_prop$US,
          step = 10, ticks = FALSE, round = FALSE,
          post = "%"
        )
      )  # close box
    ),  # close column 1
    # Column 2: Result
    column(
      width = 8,
      box(
        width = NULL,
        dataTableOutput("res_table")
      ),
      box(
        width = NULL,
        plotOutput("res_plot")
      )
    )
   ) # close `fluidRow`
  )  # close `dashboardBody`
)

