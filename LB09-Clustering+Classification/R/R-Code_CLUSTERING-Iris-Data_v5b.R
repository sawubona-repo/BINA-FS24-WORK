# --- ----------------------------------------------------------------------
# --- (Unsupervised Learning) CLUSTERING with Iris Data
# --- Hierarchical Clustering, kMeans
# --- 
# --- (c) June 2016, D.Benninger
# --- V2  June 2017, dbe		- minor bugs fixed
# --- V3  June 2019, dbe    - extended in R coding
# --- V4  June 2020, dbe    - minor extensions, plot beautifying
# --- V5b May  2021, dbe    - adapted for BINA FS21
# ---
# --- Libraries: arules, arulesViz, ggplot2, scatterplot3d, party, naivebayes
# ---            caret, MASS, randomForest
# ---
# --- Data:      iris				>> standard R dataset !
# ---
# --- Links
# --- www.datacamp.com/community/tutorials/machine-learning-in-r#gs.SpqbZhY
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
View(iris)
str(iris)
summary(iris)

# --- GRAPHICAL Summary
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

# --- HISTOGRAMS and DENSITY plots
hist(iris$Sepal.Length, breaks=10)
hist(iris$Sepal.Width, breaks=10)
hist(iris$Sepal.Length+iris$Sepal.Width)

plot(density(iris$Petal.Length))
plot(density(iris$Petal.Width))

# --- SCATTERPLOT
# --- Explore Multiple Variables
plot(iris$Sepal.Length,iris$Sepal.Width, xlim=c(0,10), ylim=c(0,10), main="Iris Data")
plot(iris$Sepal.Length,iris$Sepal.Width)
abline(a=-5,b=1.5,col="blue")

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
# --- dist calc method can be "euclidean", "maximum", "manhattan", "canberra", "binary" or "minkowski"
distMeucl <- as.matrix(dist(iris[,1:4]), method="euclidean")
heatmap(distMeucl)

# --- maximum
distMmax <- as.matrix(dist(iris[,1:4]), method="maximum")
heatmap(distMmax)

# --- manhattan
distMman <- as.matrix(dist(iris[,1:4]), method="manhattan")
heatmap(distMman)



# --- Other Visualization (cross reference, species) 
pairs(iris)

quickplot(Sepal.Length, Sepal.Width, data=iris, facets= Species ~.,color = Species)


# --------------------------------------------
# --- HIERARCHICAL Clustering (dendrogram)
# --- ----------------------------------------
clust_sepal <- hclust(dist(iris[, 1:2]))
plot(clust_sepal, xlab ="species ID", main ="Dendrogram: Sepal Measures")

clust_petal <- hclust(dist(iris[, 3:4]))
plot(clust_petal, xlab ="species ID", main ="Dendrogram: Petal Measures")

# --- use different LINKAGE Measure methods 
#  method=the agglomeration method to be used. 
# "ward.D", "ward.D2", "single", "complete", "average" (= UPGMA), "mcquitty" (= WPGMA), "median" (= WPGMC), "centroid" (= UPGMC)

par(mfrow=c(3,1))
iris_petal <- iris[,3:4]

cl <- hclust(dist(iris_petal), method="centroid")
plot(cl,main="Iris Data Dendrogram - centroid method")

cl2 <- hclust(dist(iris_petal), method="average")
plot(cl2,main="Iris Data Dendrogram - average method")

cl3 <- hclust(dist(iris_petal), method="single")
plot(cl3,main="Iris Data Dendrogram - single method")

View(cl)


# --- CLUSTERING by TREE CUTTING
par(mfrow=c(1,1))
# no of classe = 3
cl_cut<- cutree(cl,3)
plot(cl_cut)
table(cl_cut, iris$Species)

# no of classe = 2
cl_cut2<- cutree(cl,2)
table(cl_cut2, iris$Species)

# no of classe = 4
cl_cut4<- cutree(cl,4)
table(cl_cut4, iris$Species)


# --- user different Cluster Indices to measure the "goodness" of the calculated Cluster
# Quelle: https://rdrr.io/cran/clusterCrit/
#if(!"clusterCrit" %in% rownames(installed.packages())) install.packages("clusterCrit")
#library("clusterCrit")
# --- get the names of the internal indices
#getCriteriaNames(TRUE)
# --- compute all the internal indices and display one of them
#intIdx <- intCriteria(x,cl$cluster,"all")
#length(intIdx)
#intIdx[["Dunn"]]
# --- It is possible to compute only a few indices:
#intCriteria(x,cl$cluster,c("C_index","Calinski_Harabasz","Dunn"))


# --- ----------------------------------------
# --- kMEANS CLUSTERING 
# --- ----------------------------------------
# --- assure reproducibility
set.seed(20200606)

# no of classe = 3
kmcl <- kmeans(iris[, 3:4], 3, nstart = 20)
kmcl

kmcl$cluster
kmcl$centers

kmcl$totss
kmcl$withinss
kmcl$tot.withinss
kmcl$betweenss

table(kmcl$cluster, iris$Species)


# --- ELBOW Method for finding the OPTIMAL NUMBER OF CLUSTERS
set.seed(12345)

# Compute and plot wss for k = 2 to k = 15.
k.max <- 15
data <- iris[, 3:4]
tot_wss <- sapply(1:k.max, 
                  function(k){kmeans(data, k, nstart=50,iter.max = 15 )$tot.withinss})
tot_wss

# --- visualize kMeans metric tot.withinss
par(mfrow=c(1,1)) 
plot(1:k.max, tot_wss,
     type="b", pch = 19, frame = FALSE, 
     xlab="Number of clusters [K]",
     ylab="Total within-clusters sum of squares [tot.withinss]")


# --- OTHER clustering algorithms
# --- CLUSTER analysis by PAM (k-medoids) algorithm
if(!"cluster" %in% rownames(installed.packages())) install.packages("cluster")
if(!"factoextra" %in% rownames(installed.packages())) install.packages("factoextra")
library("cluster")
library("factoextra")

pamres3 <- pam(data, 3)
View(pamres3)

# --- cluster characteristics
View(pamres3)
pamres3$medoids
pamres3$clustering
pamres3$clusinfo

# --- visualize cluster calculations
fviz_cluster(pamres3,data)

# --- add classifications to the original data
iris_pamcl3 <- cbind(iris, cluster = pamres3$cluster)
iris_pamcl3
View(iris_pamcl3)
