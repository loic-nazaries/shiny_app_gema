library(shiny)
library(plotly)
library(DT)

ui <- fluidPage(

    # App title
    titlePanel("Plotly Interactive Plot"),
    
    # Sidebar layout with input and output definitions
    sidebarLayout(

        # Sidebar panel for inputs
        sidebarPanel(

            h3("Choose two variables to plot:"),

            # Select the columns to plot
            selectInput(
                inputId = "x_var",
                label = "X Variable:",
                choices = names(mtcars),
                selected = c("mpg"),
            ),

            selectInput(
                inputId = "y_var",
                label = "Y Variable:",
                choices = names(mtcars),
                selected = c("cyl"),
            ),
        ),

        # Main panel for displaying outputs
        mainPanel(

            # Display output in different tabs
            tabsetPanel(
                type = "tabs",
                tabPanel("Plot", plotlyOutput(outputId = "plot")),
                tabPanel("Summary", verbatimTextOutput(outputId = "summary")),
                tabPanel("Table", DTOutput(outputId = "table")),
            ),
        ),
    ),
)

server <- function(input, output) {

    # Filter the dataset based on selected columns and store it as a reactive expression
    filtered_data <- reactive({
        # Plotly input must be a data frame
        plot_data <- data.frame(
            x = mtcars[[input$x_var]],
            y = mtcars[[input$y_var]]
        )
        return(plot_data)
    })

    # Plotly has it's own reactive function
    output$plot <- renderPlotly({
        plot_ly(
            data = filtered_data(),
            x = ~ x,
            y = ~ y,
            type = "scatter",
            mode = "markers",
            marker = list(size = 10),
            text = ~ paste("X:", filtered_data()$x, "Y:", filtered_data()$y)
        ) %>%
            layout(
                title = paste(input$x_var, "vs.", input$y_var),
                xaxis = list(title = input$x_var),
                yaxis = list(title = input$y_var)
            )
    })

    # Generate a summary of the data
    output$summary <- renderPrint({
        summary(mtcars)
    })

    # Generate a data table
    output$table <- renderDT({
        datatable(data = mtcars)
    })
    
    # Runs every time the input changes
    observe({
        cat(
            "Selected Variables:",
            input$x_var, "&", input$y_var,
            "\n"
        )
    })
}

shinyApp(ui, server)