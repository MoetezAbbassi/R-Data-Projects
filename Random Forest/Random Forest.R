data<-read.csv(file.choose(), header=T)
str(data)

data$NSP <- as.factor(data$NSP)
table(data$NSP)
