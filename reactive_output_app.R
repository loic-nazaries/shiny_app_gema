ui <- fluidPage(
    titlePanel("censusVis"),

    sidebarLayout(
        sidebarPanel(
            helpText(
                "Create demographic maps with information from the 2010 US Census."
            ),
            tags$hr(),

            # Note the inputId property
            selectInput(
                inputId = "var",
                label = "Choose a variable to display:",
                choices = c(
                    "Percent White",
                    "Percent Black",
                    "Percent Hispanic",
                    "Percent Asian"
                ),
                selected = "Percent White", # default value
            ),

            sliderInput(
                inputId = "range",
                label = "Range of interest:",
                min = 0,
                max = 100,
                value = c(10, 95), # default values for range
            ),
        ),

        mainPanel(
            # Note the outputId property
            textOutput(outputId = "selected_var"),
            hr(),
            textOutput(outputId = "min_max"),
        )
    ),
)

server <- function(input, output) {

    # output$selected_var <- renderText({
    #     outputId = "You have selected this"
    # })
    output$selected_var <- renderText({
        paste("You have selected", input$var)
    })
    
    output$min_max <- renderText({
        paste(
            "You have chosen a range that goes from",
            input$range[1], "to", input$range[2]
        )
    })
    
}

shinyApp(ui = ui, server = server)