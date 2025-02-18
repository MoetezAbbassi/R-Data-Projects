#Goal is to classify the admission of student applications:

#Loading data:

mydata <- read.csv(file.choose(), header = T)
str(mydata)

#transforming our variables to factor/categorical variables
mydata$admit<- as.factor(mydata$admit)
mydata$rank <- as.factor(mydata$rank)

#creating a contingency table:
xtabs(~admit + rank, data=mydata)

#partitioning data: 80% training - 20% testing:

set.seed(1234)
ind <- sample(2, nrow(mydata), replace = T, prob= c(0.8, 0.2))
train <- mydata[ind==1,]
test <- mydata[ind==2,]

#Making Logistic regression model:
mymodel <- glm(admit ~ gre + gpa + rank, data= train, family= 'binomial')
summary(mymodel)

#dropping gre variable because it has high p-value
mymodel <- glm(admit ~ gpa + rank, data= train, family= 'binomial')
summary(mymodel)

#Prediction:
p1 <- predict(mymodel, train, type="response")
head(p1)
head(train)

#Mis-classification error (confusion matrix) - train data:
pred1 <- ifelse(p1>0.5, 1, 0)
tab1 <- table(Predicted=pred1, Actual= train$admit)
tab1

accuracy=1- sum(diag(tab1))/sum(tab1)
accuracy #27.07%

p2 <- predict(mymodel, test, type='response')
pred2 <- ifelse(p2 > 0.5, 1, 0)
tab2 <- table(Predicted=pred2, Actual=test$admit)

accuracy2=1- sum(diag(tab2))/sum(tab2)
accuracy2 #29.34%

#Goodness-of-fit test:
with(mymodel, pchisq(null.deviance - deviance, df.null-df.residual, lower.tail=F))
print("P-value = 1.450537e-06 ==> This Model is statistically significant")
