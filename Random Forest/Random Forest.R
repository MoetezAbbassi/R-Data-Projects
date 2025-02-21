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
rf <- randomForest(NSP~., data=train, ntree=300,
                   mtry = 8,
                   importance= TRUE,
                   proximity=TRUE)
print(rf)


attributes(rf)
rf$confusion


#Prediction & Confusion Matrix: (training data):
library(caret)
p1 <- predict(rf, train)
confusionMatrix(p1, train$NSP)

#~~ test data:
p2 <- predict(rf, test)
confusionMatrix(p2, test$NSP)

#evaluating the error rate of random forest:
plot(rf)


#Tune mtry:
tuneRF(train[,-22], train[,22],
       stepFactor = 0.5,
       plolt = TRUE,
       ntreeTry = 300,
       trace = TRUE, 
       improve= 0.05)
