library(tm)
library(stringr)
library(gtools)

normalizePhrase <- function(phrase){
    normalPhrase <- tolower(phrase)
    normalPhrase <- removePunctuation(normalPhrase)
    normalPhrase <- removeNumbers(normalPhrase)
    normalPhrase <- stripWhitespace(normalPhrase)
    return(normalPhrase)
}

matchPhrase <- function(matchPhrase){
    matchPhrase <- normalizePhrase(matchPhrase)
    splitPhrase <- strsplit(matchPhrase, split=" ")
    count <- length(splitPhrase[[1]])
    wordPattern <- paste("^",matchPhrase,sep="")
    retList <- ""
    if (count==3){
        data <- quaddata
        retList <- head(grep(wordPattern,data$terms),n=1)
        if(invalid(retList)){
            data <- tridata
            retList <- head(grep(wordPattern,data$terms),n=1)
        }
        if(invalid(retList)){
            data <- bidata
            retList <- head(grep(wordPattern,data$terms),n=1)
        }
    }
    if (count==2){
        data <- tridata
        retList <- head(grep(wordPattern,data$terms),n=1)
        if(invalid(retList)){
            data <- bidata
            retList <- head(grep(wordPattern,data$terms),n=1)
        }        
    }
    if (count==1){
        data <- bidata
        retList <- head(grep(wordPattern,data$terms),n=1)
    }
    if (count==0){
        data <- unidata
        retList <- head(grep(wordPattern,data$terms),n=1)
    }
    
    
    if (invalid(retList)) {
        retVal <- "No Results"
    } 
    else
    {
        retVal <- word(data[retList,]$terms,-1)
        
    }
    
    return(retVal)
}
