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

removeExtraWhiteSpace <- function(x) gsub("\\s+", " ", x)
cleanset <- tm_map(cleanset, content_transformer(removeExtraWhiteSpace ))
inspect(corpus[1:5])


#Term document matrix:

tdm <- TermDocumentMatrix(cleanset)
tdm
tdm <- as.matrix(tdm)
tdm[1:10, 1:20]
