library(tm)
library(stringr)
library(gtools)
quaddata = read.table("./quaddata.txt.small"
                      , colClasses = c("character","character"))
tridata = read.table("./tridata.txt.small"
                     , colClasses = c("character","character"))
bidata = read.table("./bidata.txt.small"
                    , colClasses = c("character","character"))
unidata = read.table("./unidata.txt.small", colClasses = c("character","character"))


normalizePhrase <- function(phrase){
    normalPhrase <- tolower(phrase)
    normalPhrase <- removePunctuation(normalPhrase)
    normalPhrase <- removeNumbers(normalPhrase)
    normalPhrase <- stripWhitespace(normalPhrase)
    return(normalPhrase)
}

matchPhrase <- function(matchPhrase, cnt){
    matchPhrase <- normalizePhrase(matchPhrase)
    splitPhrase <- strsplit(matchPhrase, split=" ")
    count <- length(splitPhrase[[1]])
    wordPattern <- paste("^",matchPhrase,sep="")
    retList <- ""
    if (count==3){
        data <- quaddata
        retList <- head(grep(wordPattern,data$terms),n=cnt)
        if(invalid(retList)){
            data <- tridata
            retList <- head(grep(wordPattern,data$terms),n=cnt)
            if(invalid(retList)){
                data <- bidata
                retList <- head(grep(wordPattern,data$terms),n=cnt)
                if(invalid(retList)){
                    data <- unidata
                    retList <- head(grep(wordPattern,data$terms),n=cnt)
                }
            }
            
        }
        
    }
    if (count==2){
        data <- tridata
        retList <- head(grep(wordPattern,data$terms),n=cnt)
        if(invalid(retList)){
            data <- bidata
            retList <- head(grep(wordPattern,data$terms),n=cnt)
            if(invalid(retList)){
                data <- unidata
                retList <- head(grep(wordPattern,data$terms),n=cnt)
            }
        }      
        
    }
    if (count==1){
        data <- bidata
        retList <- head(grep(wordPattern,data$terms),n=cnt)
        if(invalid(retList)){
            data <- unidata
            retList <- head(grep(wordPattern,data$terms),n=cnt)
        }
    }
    
    if (count==0){
        data <- unidata
        retList <- head(grep(wordPattern,data$terms),n=cnt)
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
