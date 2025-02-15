install.packages("BiocManager")
BiocManager::install("EBImage")
install.packages("keras")
install.packages("tensorflow")

library(EBImage)
library(keras)
library(reticulate)
library(tensorflow)
py_config()
install_tensorflow()
install_keras()




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

trainLabels


#Model Creation:

model<- keras_model_sequential()
model %>%
  layer_dense(units = 256, activation='relu', input_shape= c(2352)) %>%
  layer_dense(units=128, activation='relu') %>%
  layer_dense(units = 2, activation='softmax')

summary(model)

#Compiling the model:
model %>%
  compile(loss='binary_crossentropy',
          optimizer=optimizer_rmsprop(),
          metrics= c('accuracy'))

#Fit Model:
history <- model %>%
  fit(trainx,
      trainLabels,
      epochs=30,
      batch_size=32,
      validation_split=0.2)

plot(history)


#Evaluating and Prediction of the model: (train data)

model %>% evaluate(trainx, trainLabels)
pred <- model %>% predict_classes(trainx)
table(Predicted=pred, Actual=trainy)
prob <- model %>% predict_proba(trainx)
cbind(prob, Predicted=pred, Actual=trainy)


#Evaluation & Prediction (test data):
model %>% evaluate(testx, testLabels)
pred<- model %>% predict_classes(testx)
table(Predicted = pred, Actual= testy)
