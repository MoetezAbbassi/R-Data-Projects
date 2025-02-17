#Goal is to classify the admission of student applications:

#Loading data:

mydata <- read.csv(file.choose(), header = T)
str(mydata)

#transforming our variables to factor/categorical variables
mydata$admit<- as.factor(mydata$admit)
mydata$rank <- as.factor(mydata$rank)

xtabs(~admit + rank, data=mydata)
