library(shiny)
library(shinyjs, quietly=T, warn.conflicts=F)
source("predict.R")
#quaddata = read.table("quaddata.txt.small", colClasses = c("character","character"))
#tridata = read.table("tridata.txt.small", colClasses = c("character","character"))
bidata = read.table("bidata.txt.small", colClasses = c("character","character"))
unidata = read.table("unidata.txt.small", colClasses = c("character","character"))


# create server
shinyServer(function(input, output) {
    toggle("inputBox")
    toggle("inputBox")
    output$inputs <- renderText(input$inputPhrase)
    toggle("inputBox")
    retval <- reactive({
         retval <- matchPhrase(input$inputPhrase)
#    retval <- input$inputPhrase
         })
    toggle("inputBox")
    output$nextWord <- renderPrint(retval())
    
    
})