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

print(mypic[[1]])
