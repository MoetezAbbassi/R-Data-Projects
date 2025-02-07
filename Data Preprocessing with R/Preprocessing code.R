#Loading DHFR dataset
library(RCurl)
dhfr <- read.csv(text=getURL("https://raw.githubusercontent.com/dataprofessor/data/master/dhfr.csv"))

View(dhfr)


#Missing data:
sum(is.na(dhfr))

#Since data is clean, im introducting NA values to the dataset
na.gen <-function(data, n){
  i<- 1
  while (i<n+1){
    idx1 <-sample(1:nrow(data), 1)
    idx2 <- sample(1:ncol(data), 1)
    data[idx1, idx2] <- NA
    i=i+1
  }
  return(data)
}

#take out the Y variable
dhfr <-dhfr[, -1]

dhfr <- na.gen(dhfr, 100)
#or dhfr <- na.gen(n=100, data=dhfr) 
#BUT!!! dhfr <- na.gen(100, dhfr) DOESN'T WORK!!!

sum(is.na(dhfr))

colSums(is.na(dhfr))

str(dhfr)

#Rows with missing data:
missingdata <-dhfr[!complete.cases(dhfr),]
View(missingdata)

#Cleaning data:

clean.data <- na.omit(dhfr)

sum(is.na(clean.data))

#Imputation, replace with 
#1. Mean:
dhfr.impute<- dhfr

for(i in which(sapply(dhfr.impute, is.numeric))){
  dhfr.impute[is.na(dhfr.impute[, i]), i] <- mean(dhfr.impute[, i], na.rm=TRUE)
}

#2. Median:
dhfr.impute<- dhfr

for(i in which(sapply(dhfr.impute, is.numeric))){
  dhfr.impute[is.na(dhfr.impute[, i]), i] <- median(dhfr.impute[, i], na.rm=TRUE)
}

sum(is.na(dhfr.impute))
