# 'navbarPage' example

ui <- navbarPage(
    title = "Navbar page",
    id = "tabs",
    tabPanel(title = "Home",
        actionButton(inputId = "hideTab", label = "Hide 'Foo' tab"),
        actionButton(inputId = "showTab", label = "Show 'Foo' tab"),
        actionButton(inputId = "hideMenu", label = "Hide 'More' navbarMenu"),
        actionButton(inputId = "showMenu", label = "Show 'More' navbarMenu"),
    ),
    tabPanel(title = "Foo", "This is the foo tab"),
    tabPanel(title = "Bar", "This is the bar tab"),

    navbarMenu(
        title = "More",
        tabPanel(title = "Table", "Table page"),
        tabPanel(title = "About", "About page"),
        "------",
        "Even more!",
        tabPanel(title = "Email", "Email page"),
    ),
    br(),

    navlistPanel(
        "Header",
        tabPanel("First"),
        tabPanel("Second"),
        tabPanel("Third")
    ),
)

server <- function(input, output, session) {
    observeEvent(input$hideTab, {
        hideTab(inputId = "tabs", target = "Foo")
    })

    observeEvent(input$showTab, {
        showTab(inputId = "tabs", target = "Foo")
    })

    observeEvent(input$hideMenu, {
        hideTab(inputId = "tabs", target = "More")
    })

    observeEvent(input$showMenu, {
        showTab(inputId = "tabs", target = "More")
    })
}

shinyApp(ui = ui, server = server)