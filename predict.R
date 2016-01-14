library(tm)
library(stringr)

matchPhrase <- function(matchPhrase){
    matchPhrase <- tolower(matchPhrase)
    splitPhrase <- strsplit(matchPhrase, split=" ")
    count <- length(splitPhrase[[1]])
    wordPattern <- paste("^",matchPhrase,sep="")
    retList <- ""
    if (count==3){
        data <- quaddata
        retList <- head(grep(wordPattern,data$terms),n=1)
        if(is.na(retList)){
            data <- tridata
            retList <- head(grep(wordPattern,data$terms),n=1)
        }
        if(is.na(retList)){
            data <- bidata
            retList <- head(grep(wordPattern,data$terms),n=1)
        }
    }
    if (count==2){
        data <- tridata
        retList <- head(grep(wordPattern,data$terms),n=1)
        if(is.na(retList)){
            data <- bidata
            retList <- head(grep(wordPattern,data$terms),n=1)
        }        
    }
    if (count==1){
        data <- bidata
    }
    if (count==0){
        data <- unidata
    }
    
    
    if (is.na(retList)) {
        retVal <- "No Results"
    } else
    {
        retVal <- data.frame(word(data[retList,]$terms,-1))
        
    }
    
    return(retVal)
}
