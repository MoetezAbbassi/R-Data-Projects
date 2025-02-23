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

df %>%
  ggplot(aes(x=admit, y=gre, fill=admit))+
  geom_boxplot()+
  ggtitle("Box Plot")
