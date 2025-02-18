data<-read.csv(file.choose(), header=T)
str(data)

data$NSP <- as.factor(data$NSP)
table(data$NSP)

#Splitting the data:
set.seed(123)
ind <- sample(2, nrow(data), replace=TRUE, prob= c(0.7, 0.3))
train<- data[ind==1,]
test<- data[ind==2,]

#Random Forest:

library(randomForest)
set.seed(222)
rf <- randomForest(NSP~., data=train)
print(rf)


attributes(rf)
rf$confusion
