library(tm)
library(stringr)
matchPhrase <- function(matchPhrase, numRet){
    matchPhrase <- tolower(matchPhrase)
    splitPhrase <- strsplit(matchPhrase, split=" ")
    count <- length(splitPhrase[[1]])

    if (count==3){
        quaddata = read.table("quaddata.txt.small", colClasses = c("character","character"))
        data <- quaddata
    }
    if (count==2){
        tridata = read.table("tridata.txt.small", colClasses = c("character","character"))
        data <- tridata
    }
    if (count==1){
        bidata = read.table("bidata.txt.small", colClasses = c("character","character"))
        data <- bidata
    }
    if (count==0){
        unidata = read.table("unidata.txt.small", colClasses = c("character","character"))
        data <- unidata
    }
    wordPattern <- paste("^",matchPhrase,sep="")
    retList <- head(grep(wordPattern,data$terms),n=numRet)
    retVal <- ""
    if (length(retList) !=  0) {
    retVal <- data.frame(word(data[retList,]$terms,-1))
    } else
    {
        retVal <- "No Results"
    }
    
    return(retVal)
}

# predictWord <- function(phrase, numRet) 
# {
#     splitPhrase <- strsplit(phrase, split=" ")
#     phraseCount <- length(splitPhrase[[1]])
#     
#     if (phraseCount >= 3){
#         trimPhrase <- paste(sapply(splitPhrase,"[",(phraseCount-2):phraseCount),collapse = " ")
#         matchPhrase(splitPhrase,3,numRet)
#         }
#     if (phraseCount == 2){
#         for (i in phraseCount){
#             trimPhrase <- paste(sapply(splitPhrase,"[",(phraseCount-1):phraseCount),collapse = " ")
#             matchPhrase(splitPhrase,phraseCount,numRet)
#             }
#     }
#     if (phraseCount == 1){
#         for (i in phraseCount){
#             trimPhrase <- paste(sapply(splitPhrase,"[",phraseCount:phraseCount),collapse = " ")
#             matchPhrase(splitPhrase,phraseCount,numRet)
#             }
#     }
#     if (phraseCount == 0){
#         matchPhrase(trimPhrase,0)
#         matchPhrase(splitPhrase,phraseCount,numRet)
#         }
#     retVal <- trimPhrase
#     return(retVal)    
# }
