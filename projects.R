# install package

install.packages("caret")
install.packages("rattle")
install.packages("rpart.plot")
install.packages("randomForest")
library(caret)
library(rpart)
library(rpart.plot)
library(RColorBrewer)
library(rattle)
library(randomForest)

# Load the training dataset
dt_training <- read.csv("/Users/lizhu/Documents/R_scripts/Practical_ML/pml-training.csv", na.strings=c("NA",""), strip.white=T)

# Load the testing dataset
dt_testing <- read.csv("/Users/lizhu/Documents/R_scripts/Practical_ML/pml-testing.csv", na.strings=c("NA",""), strip.white=T)

features <- names(dt_testing[,colSums(is.na(dt_testing)) == 0])[8:59]

# Only use features used in testing cases.
dt_training <- dt_training[,c(features,"classe")]
dt_testing <- dt_testing[,c(features,"problem_id")]

# decision tree model
modFitDT <- rpart(classe ~ ., data = training, method="class")
fancyRpartPlot(modFitDT)