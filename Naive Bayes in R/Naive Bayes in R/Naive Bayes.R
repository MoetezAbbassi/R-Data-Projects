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
