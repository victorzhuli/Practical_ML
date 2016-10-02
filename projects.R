# install package

install.packages("caret")
install.packages("rattle")
install.packages("rpart.plot")
install.packages("randomForest")
install.packages('e1071', dependencies=TRUE)
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

# partitioning the data
set.seed(12345)

inTrain <- createDataPartition(dt_training$classe, p=0.6, list=FALSE)
training <- dt_training[inTrain,]
testing <- dt_training[-inTrain,]

dim(training); dim(testing);

# decision tree model
modFitDT <- rpart(classe ~ ., data = training, method="class")
fancyRpartPlot(modFitDT)
set.seed(12345)

prediction <- predict(modFitDT, testing, type = "class")
confusionMatrix(prediction, testing$class)

# random forest model
set.seed(12345)
modFitRF <- randomForest(classe ~ ., data = training, ntree = 1000)

predictionDT <- predict(modFitDT, dt_testing, type = "class")
predictionDT

predictionRF <- predict(modFitRF, dt_testing, type = "class")
predictionRF
