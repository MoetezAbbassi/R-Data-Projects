#===============================================================================
# Part 1: Exploratory Data analysis
#===============================================================================


#load dataset

install.packages("RCurl")

library(RCurl)
dhfr <- read.csv(text=getURL("https://raw.githubusercontent.com/MoetezAbbassi/Parallel-Computing/3f5ad54cb5ff3e535c3eeffdbf93e52f8739f926/dhfr.csv"))


#View the file:
View(dhfr)


#Preview:
head(dhfr,4)
tail(dhfr,4)

#summary for iris:
summary(dhfr)

is.na(dhfr)


#================================#
#Part 2: Building Classification Model
#SVM : Maximizes distance between clusters
#================================#
set.seed(100)
install.packages("caret")
library(caret)


# Split the dataset into training (80%) and testing (20%)
TrainingIndex <- createDataPartition(dhfr$Y, p = 0.8, list = FALSE)
TrainingSet <- dhfr[TrainingIndex, ]  # Training Set
TestingSet <- dhfr[-TrainingIndex, ]  # Testing Set

# Build Training Model (SVM with Polynomial Kernel)
Model <- train(Y ~ ., data = TrainingSet,
               method = "svmPoly",
               na.action = na.omit,
               preProcess = c("scale", "center"),
               trControl = trainControl(method = "none"),  # No resampling
               tuneGrid = data.frame(degree = 1, scale = 1, C = 1))

# Build Cross-Validation Model (10-fold CV)
Model.cv <- train(Y ~ ., data = TrainingSet,
                  method = "svmPoly",
                  na.action = na.omit,
                  preProcess = c("scale", "center"),
                  trControl = trainControl(method = "cv", number = 10),  # 10-fold CV
                  tuneGrid = data.frame(degree = 1, scale = 1, C = 1))

#Save file RDS
saveRDS(Model, "Model.rds")
readl.Model<-readRDS("Model.rds")

# Apply Model for Prediction
Model.training <- predict(Model, TrainingSet)  # Predictions on training set
Model.testing <- predict(Model, TestingSet)    # Predictions on testing set
Model.cv.pred <- predict(Model.cv, TestingSet) # Cross-validation predictions



# Convert to factors
Model.training <- as.factor(Model.training)
TrainingSet$Y <- as.factor(TrainingSet$Y)

# Ensure same levels
Model.training <- factor(Model.training, levels = levels(TrainingSet$Y))

Model.testing <- as.factor(Model.testing)
TestingSet$Y <- as.factor(TestingSet$Y)


# Compute Confusion Matrices
Model.training.confusion <- confusionMatrix(Model.training, TrainingSet$Y)
Model.testing.confusion <- confusionMatrix(Model.testing, TestingSet$Y)
Model.cv.confusion <- confusionMatrix(Model.cv.pred, TestingSet$Y)








# Compute confusion matrix
Model.training.confusion <- confusionMatrix(Model.training, TrainingSet$Y)
print(Model.training.confusion)

# Print Confusion Matrices
print(Model.training.confusion)
print(Model.testing.confusion)
print(Model.cv.confusion)
#Feature importance:

Importance<- varImp(Model)
plot(Importance)
plot(Importance, col="red")



#Parallel Computing:
#======================================
#Random forest
start.time <- proc.time()
Model <- train(Y ~ .,
               data =TrainingSet,
               method="rf")
stop.time <-proc.time()
run.time <- stop.time -start.time
print(run.time)

print("x")
q()


