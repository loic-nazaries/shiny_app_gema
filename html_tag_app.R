library(shiny)

ui <- fluidPage(
    titlePanel(title="title panel"),

    sidebarLayout(
        sidebarPanel(
            p("sidebar panel"),
            tags$h1("My header") # HTML equivalent: <h1>My header</h1>
        ),

        mainPanel(
            # position="right",
            h1("First level title"),
            hr(), # horizontal line
            h2("Second level title", align = "center"),
            h3("Third level title", align = "right"),
            tags$br(), # break
            a(href="https://shiny.posit.co/r/reference/shiny/latest/", "Click hyperlink!"), # hyperlink
            br(),
            strong("bold text"), em("italic text"),
            br(),
            strong(em("bold and italic text")),
            p("some text with ", div("a division")),
            p(
                "A new p() command starts a new paragraph.
                Supply a style attribute to change the format of the entire paragraph.",
                style = "font-family: 'times'; font-si16pt"
            ),
            code("code displays your text similar to computer code"),
            div(
                "div creates segments of text with a similar style.
                This division of text is all blue because I passed the argument
                'style = color:blue' to div", style = "color:blue"
            ),
            p(
                "span does the same thing as div, but it works with",
                span("groups of words", style = "color:blue"),
                "that appear inside a paragraph."
            ),
            img(src="iaschool.png", height = 172, width = 172),
            p(
                "The img function looks for your image file in a specific place.
                The file must be in a folder named www in the same directory as the
                app.R script."
            )
        ),
    ),
)

server <- function(input, output) {
    
}

shinyApp(ui = ui, server = server)