library(tm)
library(NLP)
library(RWeka)
library(slam)

options(mc.cores=1)

####Loading the Data 

# Source SwiftKey file
fileURL <- "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip"
 
if(!file.exists("swiftkey.zip")){
    download.file(fileURL, dest="swiftkey.zip",method="curl")
    unzip(zipfile="swiftkey.zip")
}
## read the files and do a line count
twitterCon <- file("./final/en_US/en_US.twitter.txt", open="rb")
blogsCon <- file("./final/en_US/en_US.blogs.txt", open="rb")
newsCon <- file("./final/en_US/en_US.news.txt", open="rb")

twitterSample <- readLines(twitterCon, encoding="UTF-8", skipNul = TRUE, n=10000)
blogSample <- readLines(blogsCon, encoding="UTF-8", skipNul = TRUE, n=10000)
newsSample <- readLines(newsCon, encoding="UTF-8", skipNul = TRUE, n=10000)

close(twitterCon) 
close(blogsCon)
close(newsCon)

 
## create the file samples
# sampleSize <- 20000
# twitterSample <- sample(twitter, sampleSize)
# blogSample <- sample(blogs, sampleSize)
# newsSample <- sample(news, sampleSize)
 
 
## combine the files
fullSample <- c(twitterSample, blogSample, newsSample)
 
sampleCorpus <- VCorpus(VectorSource(fullSample))
sampleCorpus <- tm_map(sampleCorpus, content_transformer(tolower))
sampleCorpus <- tm_map(sampleCorpus, removeNumbers)
sampleCorpus <- tm_map(sampleCorpus, removePunctuation)
sampleCorpus <- tm_map(sampleCorpus, stripWhitespace)
sampleCorpus <- tm_map(sampleCorpus,stemDocument)
sampleCorpus <- tm_map(sampleCorpus,
                     removeWords, stopwords("english"))
 
## LOGIC FOR PROFANITIES
# badWordListURL <- "http://raw.githubusercontent.com/shutterstock/List-of-Dirty-Naughty-Obscene-and-Otherwise-Bad-Words/master/en"
 
##badWordList <- download.file(badWordListURL,"badWordList.txt")
badWordList <- readLines("./badWordList.txt")
 
sampleCorpus <- tm_map(sampleCorpus,
                     removeWords, badWordList)

sampleCorpus <- tm_map(sampleCorpus, PlainTextDocument) 

## Tokenize Data
UnigramTokenizer <- function(x) {RWeka::NGramTokenizer(x, RWeka::Weka_control(min = 1, max = 1))}
unitoken <- list(tokenize = UnigramTokenizer)

BigramTokenizer <- function(x) {RWeka::NGramTokenizer(x, RWeka::Weka_control(min = 2, max = 2))}
bitoken <- list(tokenize = BigramTokenizer)

TrigramTokenizer <- function(x) {RWeka::NGramTokenizer(x, RWeka::Weka_control(min = 3, max = 3))}
tritoken <- list(tokenize = TrigramTokenizer)

QuadgramTokenizer <- function(x) {RWeka::NGramTokenizer(x, RWeka::Weka_control(min = 4, max = 4))}
quadtoken <- list(tokenize = QuadgramTokenizer)

Ngram1 <- TermDocumentMatrix(sampleCorpus,control = unitoken)
Ngram2 <- TermDocumentMatrix(sampleCorpus,control = bitoken)
Ngram3 <- TermDocumentMatrix(sampleCorpus,control = tritoken)
Ngram4 <- TermDocumentMatrix(sampleCorpus,control = quadtoken)

##ngram2 <- removeSparseTerms(ngram2, 0.1) # only keep 0.1 empty space

##Determine frequencies
Ngram1freq <- sort(rowapply_simple_triplet_matrix(Ngram1,sum), decreasing = TRUE)
Ngram2freq <- sort(rowapply_simple_triplet_matrix(Ngram2,sum), decreasing = TRUE)
Ngram3freq <- sort(rowapply_simple_triplet_matrix(Ngram3,sum), decreasing = TRUE)
Ngram4freq <- sort(rowapply_simple_triplet_matrix(Ngram4,sum), decreasing = TRUE)
 
####convert to dataframes 

ngram1df <- data.frame(terms = names(Ngram1freq),
                            freq = Ngram1freq)
ngram2df <- data.frame(terms = names(Ngram2freq),
                            freq = Ngram2freq)
ngram3df <- data.frame(terms = names(Ngram3freq),
                            freq = Ngram3freq)
ngram4df <- data.frame(terms = names(Ngram4freq),
                            freq = Ngram4freq)


write.table(ngram1df, file="unidata.txt")
write.table(ngram2df, file="bidata.txt")
write.table(ngram3df, file="tridata.txt")
write.table(ngram4df, file="quaddata.txt")

