library(data.table)
library(shiny)
library(shinydashboard)
library(shinythemes)
library(knitr)
library(shinyjs, quietly=T, warn.conflicts=F)


# create UI
shinyUI(navbarPage(useShinyjs(), 
    "Coursera Capstone Project - Word Prediction",
    theme = shinytheme("united"),
    tabPanel(
        "Prediction",
        sidebarLayout(
            position = "left",
            sidebarPanel(
                textInput("inputPhrase",
                            label = "Please enter phrase here:"
                            )
            )
            ,
            mainPanel(
                code(id = "inputBox", "Please wait, loading ..."),
                h4("You entered: "),
                h4(textOutput("inputs")),
                h4("The predicted next word: "),
                h4(textOutput("nextWord"))
            )
         )
    ),
    
    tabPanel("About",
             fluidRow(
                 column(2,
                        p("")),
                 column(8,
                        "test"),
                 column(2,
                        p(""))
             )
    )
)
)