library(tm)
library(stringr)
library(gtools)
quaddata = read.table("./quaddata.final.txt"
                      , colClasses = c("character","character"))
tridata = read.table("./tridata.final.txt"
                     , colClasses = c("character","character"))
bidata = read.table("./bidata.final.txt"
                    , colClasses = c("character","character"))
unidata = read.table("./unidata.final.txt"
                            , colClasses = c("character","character"))


normalizePhrase <- function(phrase){
    normalPhrase <- tolower(phrase)
    normalPhrase <- removePunctuation(normalPhrase)
    normalPhrase <- removeNumbers(normalPhrase)
    normalPhrase <- stripWhitespace(normalPhrase)
    return(str_trim(normalPhrase,"both"))
}

matchPhrase <- function(phrase, cnt){
    phrase <- normalizePhrase(phrase)
    splitPhrase <- strsplit(phrase, split=" ")
    count <- length(splitPhrase[[1]])
    if (count > 3){
        # capture last 3 words in phrase
        trimPhrase <- word(phrase,-3,-1)
        wordPattern <- paste("^",trimPhrase,sep="")
    } else {
        wordPattern <- paste("^",phrase,sep="")
    }
    
    retList <- ""
    if (count==3){
        mpdata <- quaddata
        retList <- head(grep(wordPattern,mpdata$terms),n=cnt)
        if(invalid(retList)){
            mpdata <- tridata
            retList <- head(grep(wordPattern,mpdata$terms),n=cnt)
            if(invalid(retList)){
                mpdata <- bidata
                retList <- head(grep(wordPattern,mpdata$terms),n=cnt)
                if(invalid(retList)){
                    mpdata <- unidata
                    retList <- head(grep(wordPattern,mpdata$terms),n=cnt)
                }
            }
            
        }
        
    }
    if (count==2){
        mpdata <- tridata
        retList <- head(grep(wordPattern,mpdata$terms),n=cnt)
        if(invalid(retList)){
            mpdata <- bidata
            retList <- head(grep(wordPattern,mpdata$terms),n=cnt)
            if(invalid(retList)){
                mpdata <- unidata
                retList <- head(grep(wordPattern,mpdata$terms),n=cnt)
            }
        }      
        
    }
    if (count==1){
        mpdata <- bidata
        retList <- head(grep(wordPattern,mpdata$terms),n=cnt)
        if(invalid(retList)){
            mpdata <- unidata
            retList <- head(grep(wordPattern,mpdata$terms),n=cnt)
        }
    }
    
    if (count==0){
        mpdata <- unidata
        retList <- head(grep(wordPattern,mpdata$terms),n=cnt)
    }
    
    result <- word(mpdata[retList,]$terms,-1)
    if (is.na(result)) {
        retVal <- "No Results"
    } 
    else
    {
        retVal <- result
    }
    
    
    return(retVal)
}
