install.packages("BiocManager")
BiocManager::install("EBImage")
install.packages("keras")

library(EBImage)
library(keras)


#reading images:
setwd("C:/Users/Moetez/Desktop/R Projects/R-Data-Projects/Image Recognition and Classification with Keras/Images")
pics <- c('p1.jpg','p2.jpg','p3.jpg','p4.jpg','p5.jpg','p6.jpg',
          'c1.jpg','c2.jpg','c3.jpg','c4.jpg','c5.jpg','c6.jpg')

mypic <- list()

for(i in 1:12) { mypic[[i]] <- readImage(pics[i])}

#Exploring
print(mypic[[1]])
display(mypic[[8]])
summary(mypic[[1]])
hist(mypic[[8]])
str(mypic)

#Resizing images(to 28x28x3):

for(i in 1:12) {mypic[[i]] <- resize(mypic[[i]], 28, 28)}


#Reshaping images:
for (i in 1:12) { mypic[[i]] <- array_reshape(mypic[[i]], c(28,28,3))}

str(mypic)


#row bind:

trainx <- NULL
for (i in 1:5) {trainx <- rbind(trainx, mypic[[i]])}
str(trainx)

testx <- rbind(mypic[[6]], mypic[[12]])
trainy <- c(0,0,0,0,0,1,1,1,1,1)
testy <- c(0,1)

#one hot encoding:

trainLabels <- to_categorical(trainy)
testLabels <- to_categorical(testy)