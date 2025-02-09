apple <- read.csv(file.choose(), header=T)
str(apple)


#building corpus
install.packages("tm")
library(tm)

corpus <- iconv(apple$text, to="UTF-8") #converting text to UTF-8 encoding format
corpus <- Corpus(VectorSource(corpus))
inspect(corpus[1:5])

#cleaning text:
corpus <- tm_map(corpus, content_transformer(tolower)) #converts to lower case
inspect(corpus[1:5])

corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeNumbers)
inspect(corpus[1:5])

cleanset <- tm_map(corpus, removeWords, stopwords('english'))

removeURL <- function(x) gsub('http[[:alnum:]]*', '', x)
cleanset <- tm_map (cleanset, content_transformer(removeURL))

#taking out "aapl", which is the most common word
cleanset <- tm_map(cleanset, removeWords, c('aapl', 'apple'))
cleanset <- tm_map(cleanset, gsub,
                   pattern='stocks', replacement='stock') #we can't replace stock by stocks

removeExtraWhiteSpace <- function(x) gsub("\\s+", " ", x)
cleanset <- tm_map(cleanset, content_transformer(removeExtraWhiteSpace ))
inspect(corpus[1:5])



#Term document matrix:
tdm <- TermDocumentMatrix(cleanset)
tdm
tdm <- as.matrix(tdm)
tdm[1:10, 1:20]

#bar plot:
w <- rowSums(tdm)
w <- subset(w, w>=25)

barplot(w,
        las=2,
        col=rainbow(50))

#word cloud:
install.packages("wordcloud")
install.packages("wordcloud2")
library(wordcloud)
library(wordcloud2)


w <- sort(rowSums(as.matrix(tdm)), decreasing = TRUE)
set.seed(222)
wordcloud2(data.frame(word = names(w), freq = w), size = 1.5, color='random-light', backgroundColor="black")

w <- sort(rowSums(tdm), decreasing = TRUE)
set.seed(222)
wordcloud(words = names(w),
          freq = w,
          min.freq = 5,
          colors = brewer.pal(8, 'Dark2'),
          scale= c(5, 0.3),
          rot.per = 0.7)
 
#sentiment analysis:
library(syuzhet)
library(lubridate)
library(ggplot2)
library(scales)
library(reshape2)
library(dplyr)

#obtaining sentiment scores
apple<- read.csv(file.choose(), header=T)
tweets <- iconv(apple$text, to='UTF-8')
S<- get_nrc_sentiment(tweets)
head(S)
tweets[4]
get_nrc_sentiment('ugly')
get_nrc_sentiment('delay')

#bar plot:
barplot(colSums(S),
        las=2,
        col=rainbow(10),
        ylab='Count',
        main='Sentiment scores for apple tweets')
 