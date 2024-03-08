# Load packages ----
library(shiny)
library(quantmod)

# Source helpers ----
# Contains a function that adjusts stock prices for inflation
source("helpers.R")

# User interface ----
ui <- fluidPage(
    titlePanel("stockVis"),

    sidebarLayout(
        sidebarPanel(
            helpText(
                "Select a stock to examine.
                Information will be collected from Yahoo finance."
            ),

            textInput(
                inputId = "symb",
                label = "Symbol",
                value = "SPY",
            ),

            dateRangeInput(
                inputId = "dates",
                label = "Date range",
                start = "2013-01-01",
                end = as.character(Sys.Date()),
            ),

            br(),
            br(),

            checkboxInput(
                inputId = "log",
                label = "Plot y axis on log scale",
                value = FALSE, # box not checked by default
            ),

            checkboxInput(
                inputId = "adjust",
                label = "Adjust prices for inflation",
                value = FALSE,
            ),
        ),

        mainPanel(plotOutput(outputId = "plot")),
    ),
)

# Server logic
server <- function(input, output) {

    # output$plot <- renderPlot({
    #     data <- getSymbols(
    #         input$symb,
    #         src = "yahoo",
    #         from = input$dates[1],
    #         to = input$dates[2],
    #         auto.assign = FALSE,
    #     )

    #     chartSeries(
    #         data,
    #         theme = chartTheme("white"),
    #         type = "line",
    #         log.scale = input$log,
    #         TA = NULL,
    #     )
    # })

    dataInput <- reactive({
        # Download financial data
        getSymbols(
            input$symb,
            src = "yahoo",
            from = input$dates[1],
            to = input$dates[2],
            auto.assign = FALSE,
        )
    })
    
    finalInput <- reactive({
        # Adjust or not data
        if (!input$adjust) return(dataInput())
        adjust(data = dataInput()) # see helpers.R for the 'adjust' function arguments
    })

    output$plot <- renderPlot({
        # Display prices in an attractive chart
        chartSeries(
            finalInput(),
            theme = chartTheme("white"),
            type = "line",
            log.scale = input$log,
            TA = NULL,
        )
    })

}

# Run the app
shinyApp(ui, server)