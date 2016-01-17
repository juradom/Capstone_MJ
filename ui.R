library(data.table)
library(shiny)
library(shinydashboard)
library(shinythemes)
library(knitr)
library(shinyjs, quietly=T, warn.conflicts=F)
library(rmarkdown)
library(ggplot2)


# create UI
shinyUI(navbarPage(title = "Coursera Data Science Capstone",
                   theme = shinytheme("cerulean"),
                 
                   
    tabPanel("Word Prediction",
        sidebarLayout(
            position = "left",
            sidebarPanel(
                
                
                textInput("inputPhrase",
                            label = "Please enter phrase here:"
                            ),
                sliderInput("sliderVal","Max # of Predicted Words",1,10,1)
            )
            ,
            mainPanel(
                useShinyjs(),
                code(id = "inputBox", "Please wait, loading ..."),
                h4("You entered: "),
                h4(textOutput("inputs")),
                h1(""),
                h4("The predicted word(s) is/are: "),
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