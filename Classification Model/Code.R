#===============================================================================
# Part 1: Exploratory Data analysis
#===============================================================================


#Method 1 to install iris dataset

library("datasets")
data("iris")
iris <- datasets::iris
View(iris)

#Method 2 to install iris dataset

install.packages("RCurl")

library(RCurl)
iris <- read.csv(text=getURL("https://raw.githubusercontent.com/MoetezAbbassi/Classification-Model-with-R/refs/heads/main/iris.csv?token=GHSAT0AAAAAAC6CJGKT46DO6YNTMT6N2RCCZ454ILA"))


#View the file:
View(iris)


#Preview:
head(iris,4)
tail(iris,4)

#summary for iris:
summary(iris)
iris$Sepal.Length

is.na(iris)

#install skinr package:
install.packages("skimr")

library(skimr)
skim(iris) #summary statistics

iris %>%
  dplyr::group_by(Species) %>%
  skim()

#================================================
#¨Part 2: Data Visualization
#================================================

plot(iris)
plot(iris, col="red")

plot(iris$Sepal.Length, iris$Sepal.Width, col="green", xlab="Sepal Length", ylab="Width")

hist(iris$Sepal.Width, col="blue")

#Feature Plot:
install.packages("caret")
library(caret)
library(ggplot2)

# Create the feature plot with boxplots

featurePlot(x = iris[, 1:4], 
            y = iris$Species)
# Make sure Species is a factor
iris$Species <- as.factor(iris$Species)

# Create the feature plot
featurePlot(x = iris[, 1:4], 
            y = iris$Species)

iris_long <- reshape2::melt(iris, id.vars = "Species")

# Boxplot for each feature
ggplot(iris_long, aes(x = Species, y = value)) +
  geom_boxplot() +
  facet_wrap(~variable, scales = "free") +
  theme_minimal()


featurePlot(x = iris[, 1:4],  # Features (Sepal.Length, Sepal.Width, etc.)
            y = iris$Species,  # Target variable (Species)
            plot = "box",  # Type of plot (boxplot)
            strip = strip.custom(par.strip.text = list(cex = 0.7)),  # Custom text size for strip labels
            scales = list(x = list(relation = "free"),  # Allow free scaling on x-axis
                          y = list(relation = "free")))  # Allow free scaling on y-axis

#================================#
#Part 3: Building Classification Model
#SVM : Maximizes distance between clusters
#================================#
set.seed(100)

# Split the dataset into training (80%) and testing (20%)
TrainingIndex <- createDataPartition(iris$Species, p = 0.8, list = FALSE)
TrainingSet <- iris[TrainingIndex, ]  # Training Set
TestingSet <- iris[-TrainingIndex, ]  # Testing Set

# Build Training Model (SVM with Polynomial Kernel)
Model <- train(Species ~ ., data = TrainingSet,
               method = "svmPoly",
               na.action = na.omit,
               preProcess = c("scale", "center"),
               trControl = trainControl(method = "none"),  # No resampling
               tuneGrid = data.frame(degree = 1, scale = 1, C = 1))

# Build Cross-Validation Model (10-fold CV)
Model.cv <- train(Species ~ ., data = TrainingSet,
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

# Compute Confusion Matrices
Model.training.confusion <- confusionMatrix(Model.training, TrainingSet$Species)
Model.testing.confusion <- confusionMatrix(Model.testing, TestingSet$Species)
Model.cv.confusion <- confusionMatrix(Model.cv.pred, TestingSet$Species)

# Print Confusion Matrices
print(Model.training.confusion)
print(Model.testing.confusion)
print(Model.cv.confusion)
#Feature importance:

Importance<- varImp(Model)
plot(Importance)
plot(Importance, col="red")
