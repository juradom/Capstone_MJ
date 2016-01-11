library(tm)
library(SnowballC)
matchPhrase <- function(matchPhrase, count, numRet){

    ##stemPhrase <- wordStem(matchPhrase)

    if (count==3){
        quaddata = read.table("quaddataStem.txt", colClasses = c("character","character"))
        data <- quaddata
    }
    if (count==2){
        tridata = read.table("tridataStem.txt", colClasses = c("character","character"))
        data <- tridata
    }
    if (count==1){
        bidata = read.table("bidataStem.txt", colClasses = c("character","character"))
        data <- bidata
    }
    if (count==0){
        unidata = read.table("unidataStem.txt", colClasses = c("character","character"))
        data <- unidata
    }
    
#     phraseDF<-data.frame(text=unlist(sapply(samplePhrase, `[`, "content")), 
#                           stringsAsFactors=F)
    wordPattern <- paste("^",matchPhrase,sep="")
    retList <- head(grep(wordPattern,data$stems),n=numRet)
    retVal <- ""
    if (length(retList) !=  0) {
    retVal <- data.frame(retVal, data[retList,])
    } else
    {
        retVal <- NULL
    }
    
    return(retVal)
}

matchPhraseAny <- function(matchPhrase, count, numRet){
    
    samplePhrase <- VCorpus(VectorSource(matchPhrase))
    samplePhrase <- tm_map(samplePhrase, content_transformer(tolower))
    samplePhrase <- tm_map(samplePhrase, removeNumbers)
    samplePhrase <- tm_map(samplePhrase, removePunctuation)
    samplePhrase <- tm_map(samplePhrase, stripWhitespace)
    samplePhrase <- tm_map(samplePhrase,stemDocument)
    samplePhrase <- tm_map(samplePhrase,
                           removeWords, stopwords("english"))
    if (count==3){
        quaddata = read.table("quaddata.txt", colClasses = c("character","character"))
        data <- quaddata
    }
    if (count==2){
        tridata = read.table("tridata.txt", colClasses = c("character","character"))
        data <- tridata
    }
    if (count==1){
        bidata = read.table("bidata.txt", colClasses = c("character","character"))
        data <- bidata
    }
    if (count==0){
        unidata = read.table("unidata.txt", colClasses = c("character","character"))
        data <- unidata
    } 
    retList <- head(grep(samplePhrase,data$terms),n=numRet)
    retVal <- ""
    retVal <- data.frame(retVal, data[retList,])
    return(retVal)
}

predictWord <- function(phrase) 
{
    splitPhrase <- strsplit(phrase, split=" ")
    phraseCount <- length(splitPhrase[[1]])
    
    if (phraseCount >= 3){
        trimPhrase <- paste(sapply(splitPhrase,"[",(phraseCount-2):phraseCount),collapse = " ")
    }
    if (phraseCount == 2){
        for (i in phraseCount){
            trimPhrase <- paste(sapply(splitPhrase,"[",(phraseCount-1):phraseCount),collapse = " ")
        }
    }
    if (phraseCount == 1){
        for (i in phraseCount){
            trimPhrase <- paste(sapply(splitPhrase,"[",phraseCount:phraseCount),collapse = " ")
        }
    }
    if (phraseCount == 0){
        matchPhrase(trimPhrase,0)
        }
    retVal <- trimPhrase
    return(retVal)    
}
