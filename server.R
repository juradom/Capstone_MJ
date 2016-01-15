library(shiny)
library(shinyjs, quietly=T, warn.conflicts=F)
library(stringr)
source("predict.R")
quaddata = read.table("quaddata.txt.small", colClasses = c("character","character"))
tridata = read.table("tridata.txt.small", colClasses = c("character","character"))
bidata = read.table("bidata.txt.small", colClasses = c("character","character"))
unidata = read.table("unidata.txt.small", colClasses = c("character","character"))


# create server
shinyServer(function(input, output) {
    shinyjs::toggle("inputBox")
    output$inputs <- renderText(input$inputPhrase)
    output$nextWord <- renderPrint({
         matchPhrase(input$inputPhrase)
         })
    #output$nextWord <- renderPrint(retval)
    
    
})