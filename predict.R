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

retList <- as.null()
normalizePhrase <- function(phrase){
    normalPhrase <- tolower(phrase)
    normalPhrase <- removePunctuation(normalPhrase)
    normalPhrase <- removeNumbers(normalPhrase)
    normalPhrase <- stripWhitespace(normalPhrase)
    return(str_trim(normalPhrase,"both"))
}
trimPhrase <- function(phrase,len1,len2){
    return(word(phrase,len1,len2))
}
matchPhrase <- function(phrase, cnt){
    phrase <- normalizePhrase(phrase)
    splitPhrase <- strsplit(phrase, split=" ")
    count <- length(splitPhrase[[1]])
#     if (count > 3){
#         # capture last 3 words in phrase
#         trimPhrase <- word(phrase,-3,-1)
#         wordPattern <- paste("^",trimPhrase,sep="")
#     } else {
#         wordPattern <- paste("^",phrase,sep="")
#     }
    wordPattern <- paste("^",phrase,sep="")
    if (count>=3){
        wordPattern <- paste("^",trimPhrase(phrase,-3,-1),sep="")
        retList <- head(grep(wordPattern,quaddata$terms),n=cnt)
        retVal <- word(quaddata[retList,]$terms,-1)
        if(invalid(retList)){
            wordPattern <- paste("^",trimPhrase(phrase,-2,-1),sep="")
            retList <- head(grep(wordPattern,tridata$terms),n=cnt)
            retVal <- word(tridata[retList,]$terms,-1)
            if(invalid(retList)){
                wordPattern <- paste("^",trimPhrase(phrase,-1,-1),sep="")
                retList <- head(grep(wordPattern,bidata$terms),n=cnt)
                retVal <- word(bidata[retList,]$terms,-1)
                if(invalid(retList)){
                    retList <- head(grep("",unidata$terms),n=cnt)
                    retVal <- word(unidata[retList,]$terms,-1)
                }
            }
            
        }
        
    }
    if (count==2){
        wordPattern <- paste("^",trimPhrase(phrase,-2,-1),sep="")
        retList <- head(grep(wordPattern,tridata$terms),n=cnt)
        retVal <- word(tridata[retList,]$terms,-1)
        if(invalid(retList)){
            wordPattern <- paste("^",trimPhrase(phrase,-1,-1),sep="")
            retList <- head(grep(wordPattern,bidata$terms),n=cnt)
            retVal <- word(bidata[retList,]$terms,-1)
            if(invalid(retList)){
                retList <- head(grep(wordPattern,unidata$terms),n=cnt)
                retVal <- word(unidata[retList,]$terms,-1)
            }
        }      
        
    }
    if (count==1){
        wordPattern <- paste("^",trimPhrase(phrase,-1,-1),sep="")
        retList <- head(grep(wordPattern,bidata$terms),n=cnt)
        retVal <- word(bidata[retList,]$terms,-1)
        if(invalid(retList)){
            retList <- head(grep("",unidata$terms),n=cnt)
            retVal <- word(unidata[retList,]$terms,-1)
        }
    }
    
    if (count==0){
        retList <- head(grep("",unidata$terms),n=cnt)
        retVal <- word(unidata[retList,]$terms,-1)
    }
    
    if (invalid(retList)) {
        retVal <- "No Results"
    } 
    else
    {
        retVal
    }
    
    
    return(retVal)
}
