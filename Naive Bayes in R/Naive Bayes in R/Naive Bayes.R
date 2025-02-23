install.packages("naivebayes")
install.packages("dplyr")
install.packages("ggplot2")
install.packages("psych")



library(naivebayes)
library(dplyr)
library(ggplot2)
library(psych)

#reading data
df= read.csv(file.choose(), header=T)
str(df)
df$rank <- as.factor(df$rank)
df$admit <- as.factor(df$admit)

#visualization:
pairs.panels(df[-1])
##boxplot
df %>%
  ggplot(aes(x=admit, y=gre, fill=admit))+
  geom_boxplot()+
  ggtitle("Box Plot")
##density plot
df %>% ggplot(aes(x=gre, fill=admit)) +
  geom_density(alpha=0.8, color='black')+
                 ggtitle("Density plot")


#data splitting
set.seed(1234)
ind <- sample(2,nrow(df),replace=T,prob=c(0.8, 0.2))
train <- df[ind==1,]
test<- df[ind==2,]


#Naive Bayes Model:
model <- naive_bayes(admit ~ ., data=train)
model


train %>%
  filter(admit=="1") %>%
           summarise(mean(gre), sd(gre))

plot(model)


#Predict
p