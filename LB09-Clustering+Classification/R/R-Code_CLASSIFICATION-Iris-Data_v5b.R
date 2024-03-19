# --- ----------------------------------------------------------------------
# --- (Supervised Learning) CLASSIFICATION with Iris Data
# --- Decision Tree, Random Forest, NaiveBayes
# --- 
# --- (c) June 2016, D.Benninger
# --- V2  June 2017, dbe		- minor bugs fixed
# --- V3  June 2019, dbe    - extended in R coding
# --- V4  June 2020, dbe    - minor extensions, plot beautifying
# --- V5  May  2021, dbe    - adapted for BINA FS21
# ---
# --- Libraries: arules, arulesViz, ggplot2, scatterplot3d, party, naivebayes
# ---            caret, MASS, randomForest
# ---
# --- Data:      iris				>> standard R dataset !
# ---
# --- Links
# --- www.datacamp.com/community/tutorials/machine-learning-in-r#gs.SpqbZhY
# --- (Naive Bayes for IRIS data -> https://bicorner.com/2015/07/16/naive-bayes-using-r/
# ---
# --- ----------------------------------------------------------------------

# Packages installieren, falls nicht vorhanden
if(!"ggplot2" %in% rownames(installed.packages())) install.packages("ggplot2")
if(!"arules" %in% rownames(installed.packages())) install.packages("arules")
if(!"arulesViz" %in% rownames(installed.packages())) install.packages("arulesViz")
if(!"scatterplot3d" %in% rownames(installed.packages())) install.packages("scatterplot3d")
if(!"party" %in% rownames(installed.packages())) install.packages("party")
if(!"caret" %in% rownames(installed.packages())) install.packages("caret")
if(!"randomForest" %in% rownames(installed.packages())) install.packages("randomForest")
if(!"MASS" %in% rownames(installed.packages())) install.packages("MASS")
if(!"naivebayes" %in% rownames(installed.packages())) install.packages("naivebayes")

# Packages laden
library("ggplot2")
library("arules")
library("arulesViz")

# Set Working Directory
# setwd(choose.dir())
# getwd()

# -----------------------------------------
# --- DATA Overview and Statistical Summary
# -----------------------------------------
iris
str(iris)
summary(iris)
View(iris)

# --- Graphical Summary
plot(iris)
ggplot(iris, aes(Petal.Length, Petal.Width)) + geom_point()
ggplot(iris, aes(Petal.Length, Petal.Width, color = Species)) + geom_point()

# --- Attribute Statistical Key Values
# --- Explore Individual Variables
boxplot(iris$Sepal.Length, main="Sepal.Length")
boxplot(iris$Petal.Length, main="Petal.Length")

par(mfrow=c(1,2))
boxplot(iris$Petal.Length, iris$Petal.Width, main="Petal Measures")
boxplot(iris$Sepal.Length, iris$Sepal.Width, main="Sepal Measures")

par(mfrow=c(1,1))
boxplot(iris$Sepal.Length, iris$Sepal.Width, iris$Petal.Length, iris$Petal.Width, main="IRIS Measures", ylab ="length/width in cm")
boxplot(Sepal.Length ~ Species, data=iris, xlab="Species", ylab="Sepal.Length")

# --- Histograms and Density plots
hist(iris$Sepal.Length, breaks=10)
hist(iris$Sepal.Length, breaks=20)
hist(iris$Sepal.Width, breaks=20)
hist(iris$Sepal.Length+iris$Sepal.Width)
hist(iris$Sepal.Length+iris$Sepal.Width, breaks=20)

plot(density(iris$Petal.Length))
plot(density(iris$Petal.Width))

# --- SCATTERPLOT
# --- Explore Multiple Variables
plot(iris$Sepal.Length,iris$Sepal.Width, xlim=c(0,10), ylim=c(0,10), main="Iris Data")
plot(iris$Sepal.Length,iris$Sepal.Width)

plot(iris$Sepal.Length, iris$Sepal.Width, pch=21, bg=c("red","green3","blue")[unclass(iris$Species)], main="Iris Data")
abline(a=-3.8,b=1.3,col="blue")

plot(iris$Sepal.Width, iris$Sepal.Length, pch=21, bg=c("red","green3","blue")[unclass(iris$Species)], main="Iris Data")
abline(a=0.75,b=1.5,col="black")

plot(iris$Sepal.Length, iris$Sepal.Width, col=iris$Species, pch=as.numeric(iris$Species), main="Iris Data Scatterplot")

library(scatterplot3d)
scatterplot3d(iris$Petal.Width,iris$Sepal.Length,iris$Sepal.Width)
scatterplot3d(iris$Petal.Width,iris$Sepal.Length,iris$Sepal.Width, pch=21, bg=c("red","green3","blue")[unclass(iris$Species)])

# --- Smooth SCATTERPLOT
smoothScatter(iris$Sepal.Length,iris$Sepal.Width)

# --- DISTANCE Measures and HEAT Map
distM <- as.matrix(dist(iris[,1:4]), method="euclidean")
heatmap(distM)

# --- Other Visualization (cross reference, species) 
pairs(iris)

quickplot(Sepal.Length, Sepal.Width, data=iris, facets= Species ~.,color = Species)


# --- ----------------------------------------
# --- DECISION TREES & Random Forests
# --- ----------------------------------------
str(iris)
set.seed(1234)

# --- (random) split into TRAININGS + TEST data
ind <- sample(2,nrow(iris), replace=TRUE,prob=c(0.7,0.3))
trainData <- iris[ind==1,]
testData <- iris[ind==2,]

library(party)

myForm <- Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width
iris_ctree <- ctree(myForm, data=trainData)

# --- check the Classifier (--> CONFUSION matrix)
table(predict(iris_ctree), trainData$Species)
print (iris_ctree)

t<- table(predict(iris_ctree), trainData$Species)
View(t)

# --- VISUALIZE Decision Tree
plot(iris_ctree)
plot(iris_ctree, type="simple")

# --- PREDICT on test data
test_Pred <- predict(iris_ctree, newdata= testData)
table(test_Pred, testData$Species)

tp<- table(predict(iris_ctree), trainData$Species)
View(tp)

# --- compute QUALITY Measures by Confusion Matrix
library(caret)
library(e1071)
zpred <- table(test_Pred, testData$Species)
confusionMatrix(zpred)

# -----------------------------------------
# --- RANDOMFOREST
# -----------------------------------------
library("randomForest")
library("MASS")

rf <- randomForest(Species~., data=trainData)
rf
View(rf)

attributes(rf)
rf$confusion

# --- Prediction and Confusion matrix on *TRAIN* data (100% accuracy)
rfpred1 <- predict(rf, trainData)
head(rfpred1)
summary(rfpred1)

confusionMatrix(rfpred1, trainData$Species)

# --- Prediction and Confusion matrix on *TEST* data (94,7% accuracy)
rfpred2 <- predict(rf, testData)
head(rfpred2)
summary(rfpred1)

confusionMatrix(rfpred2, testData$Species)

# --- Error Rate in random forest model
# --- at 200 there is a constant line and it doesnot vary after 200 trees
plot(rf)

# --- TUNE random forest model mtry 
 tune <- tuneRF(trainData[,-5], trainData[,5], stepFactor = 0.5, plot = TRUE, ntreeTry = 300,
               trace = TRUE, improve = 0.05)

 rf1 <- randomForest(Species~., data=trainData, ntree = 140, mtry = 2, importance = TRUE,
                    proximity = TRUE)
 rf1
 plot(rf1)

# --- test data prediction using the tuned RF1 model
# --- 96 % accuracy on test data
 pred2 <- predict(rf1, testData)
 confusionMatrix(pred2, testData$Species)

# --- no of nodes of trees
 hist(treesize(rf1), main = "No of Nodes for the trees", col = "green")

 importance(rf1)

# --- partial dependence plot
# --- if the petal.length is between 2.5 to 5,5, then it is Versicolor
# --- if the petal.length is between 1 to 3 cms in length, then it is setosa
# --- if the petal.length is greater than 3 cms in length, then it is Virginica
 partialPlot(rf1, trainData, Petal.Length, "versicolor", main="partial dependence on Petal.Lenght, Species versicolor")
 partialPlot(rf1, trainData, Petal.Length, "setosa", main="partial dependence on Petal.Lenght, Species setosa")
 partialPlot(rf1, trainData, Petal.Length, "virginica", , main="partial dependence on Petal.Lenght, Species virginica")

# --- extract SINGLE TREE (1st) from the FOREST
 tr1 <- getTree(rf1, 1, labelVar = TRUE)
 tr1
 View(tr1)

# --- plot a single tree
# https://shiring.github.io/machine_learning/2017/03/16/rf_plot_ggraph

# --- ----------------------------------------
# --- NAIVE BAYES Clustering and Model Training
# --- ----------------------------------------
library("naivebayes")
nBcl <- naive_bayes(iris$Species ~ ., data = iris)

nBcl_predict <- predict(nBcl,iris[,-1])

table(nBcl_predict,true=iris$Species)
mean(nBcl_predict==iris$Species)
nBcl_conf <- table(nBcl_predict,true=iris$Species)
confusionMatrix(nBcl_conf)

# --- SPLIT first train and test data (80:20)
bound <- floor((nrow(iris)/5)*4)

iris_sample <- iris[sample(nrow(iris)), ]
iris.train <- iris_sample[1:bound, ]
iris.test <- iris_sample[(bound+1):nrow(iris_sample), ]

# --- TRAIN the model with train data
n_iris_model <- naive_bayes(iris.train$Species ~ ., data = iris.train)
n_iris_model
View(n_iris_model)
plot(n_iris_model)

# --- TEST predictor on test data
n_iris_predict <- predict(n_iris_model,iris.test[,-1])

# --- EVALUATE predictor on test data
table(n_iris_predict,true=iris.test$Species)
mean(n_iris_predict==iris.test$Species)
n_iris_conf <- table(n_iris_predict,true=iris.test$Species)
confusionMatrix(nBcl_conf)
