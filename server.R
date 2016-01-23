library(shiny)
library(shinyjs, quietly=T, warn.conflicts=F)
library(stringr)
library(rmarkdown)
library(ggplot2)

source("predict.R")

quaddata = read.table("./quaddata.final.txt"
                      , colClasses = c("character","character"))
tridata = read.table("./tridata.final.txt"
                     , colClasses = c("character","character"))
bidata = read.table("./bidata.final.txt"
                    , colClasses = c("character","character"))
unidata = read.table("./unidata.final.txt"
                     , colClasses = c("character","character"))

# create server
shinyServer(function(input, output) {
    shinyjs::toggle("inputBox")
    output$inputs <- renderText(input$inputPhrase)
    #output$trimCnt <- reactive(-1*(length(strsplit(normalizePhrase(input$inputPhrase),split=" ")[[1]])-1))
    output$trimInputs <- renderText(word(normalizePhrase(input$inputPhrase),
                                         -1*(length(strsplit(normalizePhrase(input$inputPhrase),split=" ")[[1]])-1)
                                         ,-1))
    output$nextWord <- renderPrint({
        matchPhrase(input$inputPhrase, input$sliderVal)
         })
    
    
})