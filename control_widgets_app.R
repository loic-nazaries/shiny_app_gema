library(shiny)
library(datasets)

mpgData <- mtcars
mpgData$am <- factor(mpgData$am, labels = c("Automatic", "Manual"))


# Define UI ----
ui <- fluidPage(
    titlePanel("Basic widgets"),

    fluidRow(

        column(
            width = 3,
            h3("Buttons"),
            actionButton(
                inputId = "action",
                label = "Action",
            ),
            br(),
            br(),
            submitButton("Submit"),
        ),

        column(
            width = 3,
            h3("Single checkbox"),
            checkboxInput(
                inputId = "checkbox",
                label = "Choice A",
                value = TRUE,
            ),
        ),

        column(
            width = 3,
            checkboxGroupInput(
                inputId = "checkGroup",
                label = h3("Checkbox group"),
                choices = list(
                    "Choice 1" = 1,
                    "Choice 2" = 2,
                    "Choice 3" = 3
                ),
                selected = 1,
            ),
        ),

        column(
            width = 3,
            dateInput(
                inputId = "date",
                label = h3("Date input"),
                value = "2014-01-01",
            ),
        ),
    ),

    fluidRow(

        column(
            width = 3,
            dateRangeInput(
                inputId = "dates",
                label = h3("Date range"),
            ),
        ),

        column(
            width = 3,
            fileInput(
                inputId = "file",
                label = h3("File input"),
            ),
        ),

        column(
            width = 3,
            h3("Help text"),
            helpText(
                "Note: help text isn't a true widget,",
                "but it provides an easy way to add text to",
                "accompany other widgets."),
            ),

        column(
            width = 3,
            numericInput(
                inputId = "num",
                label = h3("Numeric input"),
                value = 1,
            ),
        ),
    ),

    fluidRow(

        column(
            width = 3,
            radioButtons(
                inputId = "radio",
                label = h3("Radio buttons"),
                choices = list(
                    "Choice 1" = 1,
                    "Choice 2" = 2,
                    "Choice 3" = 3
                ),
                selected = 1,
            ),
        ),

        column(
            width = 3,
            selectInput(
                inputId = "select",
                label = h3("Select box"),
                choices = list(
                    "Choice 1" = 1,
                    "Choice 2" = 2,
                    "Choice 3" = 3
                ),
                selected = 1,
            ),
        ),

        column(
            width = 3,
            sliderInput(
                inputId = "slider1",
                label = h3("Sliders"),
                min = 0,
                max = 100,
                value = 50,
            ),
            sliderInput(
                inputId = "slider2",
                label = "",
                min = 0,
                max = 100,
                value = c(25, 75),
            ),
        ),

        column(
            width = 3,
            textInput(
                inputId = "text",
                label = h3("Text input"),
                value = "Enter text...",
            ),
            textAreaInput(
                inputId = "text_area",
                label = h3("Text area"),
                value = "Enter text...",
            ),
        ),
    ),
    hr(),

    fluidRow(

        column(
            width = 3,
            varSelectInput(
                inputId = "var_selection",
                label = h3("Variable selection"),
                data = mpgData,
            ),
        ),

        column(
            width = 3,
            h3("Download button"),
            downloadButton(
                outputId = "downloadData",
                label = "Download",
                value = "Password",
            ),
        ),

        column(
            width = 3,
            passwordInput(
                inputId = "password",
                label = h3("Enter password"),
            ),
        ),

    ),

    fluidRow(
        
        downloadButton(
            outputId = "downloadData",
            label = "Download",
            value = "Password",
        ),
        passwordInput(
            inputId = "password",
            label = h3("Enter password"),
        ),
    ),

    downloadButton(
        outputId = "downloadData",
        label = "Download",
        value = "Password",
    ),

    passwordInput(
        inputId = "password",
        label = h3("Enter password"),
    ),
)

# Define server logic ----
server <- function(input, output) {

}

# Run the app ----
shinyApp(ui = ui, server = server)