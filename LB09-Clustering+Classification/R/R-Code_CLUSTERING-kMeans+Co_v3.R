# --- ----------------------------------------------------------------------
# --- CLUSTERING kMEANS + Co Examples 
# --- 
# --- (c) June 2020, D.Benninger
# ---  
# ---
# --- Libraries: cluster, factoextra, ggplot2, proxy, TSDist 
# ---           (+standard R plot functions plot, qplot, hist)
# ---
# --- Data:  USArrests     (US Arrest Data from 50 States)    
# ---
# --- Links
# ---   https://www.r-bloggers.com/the-ultimate-guide-to-partitioning-clustering/
# ---   https://www.rdocumentation.org/packages/factoextra
# ---   
# ---
# --- Version
# ---    V1 June 2020 dbe
# ---    V2 May  2021 dbe - extendet and adapted for BINA FS21
# --- ----------------------------------------------------------------------

# Set WORKING Directory
# setwd(choose.dir())
# getwd()

# --- Packages installieren, falls nicht vorhanden
if(!"cluster" %in% rownames(installed.packages())) install.packages("cluster")
if(!"factoextra" %in% rownames(installed.packages())) install.packages("factoextra")
if(!"ggplot2" %in% rownames(installed.packages())) install.packages("ggplot2")
if(!"proxy" %in% rownames(installed.packages())) install.packages("proxy")
if(!"TSdist" %in% rownames(installed.packages())) install.packages("TSdist")

# --- Packages laden
library("cluster")
library("factoextra")
library("ggplot2")
library("proxy")
library("TSdist")

# -----------------------------------------
# --- DATA Overview and Statistical Summary
# -----------------------------------------
# --- load (raw) data
xraw<-USArrests
xraw
head(xraw)
str(xraw)
summary(xraw)

# --- Graphical Summary
par(mfrow=c(1,4)) 
boxplot(summary(xraw[,1]), main = "Murder")
boxplot(summary(xraw[,2]), main = "Assault")
boxplot(summary(xraw[,3]), main = "UrbanPop")
boxplot(summary(xraw[,4]), main = "Rape")


# --- SCALE raw data (by Z-TRANSFORMATION)
# ----------------------------------------
xstd <- scale(xraw)
xstd
head(xstd)
str(xstd)
summary(xstd)

par(mfrow=c(1,4)) 
boxplot(summary(xstd[,1]), main = "Murder")
boxplot(summary(xstd[,2]), main = "Assault")
boxplot(summary(xstd[,3]), main = "UrbanPop")
boxplot(summary(xstd[,4]), main = "Rape")

# ----------------------------------------
# --- CLUSTER ANALYSIS by KMEANS algorithm
# ----------------------------------------
set.seed(12345)

# --- Calculate and Visualize CLUSTER
# --- no of clusters = 3 
kmres3 <- kmeans(xstd,centers=3,nstart=25)
fviz_cluster(kmres3, xstd)

View(kmres3)

# --- no of clusters = 4
kmres4 <- kmeans(xstd,centers=4,nstart=25)
fviz_cluster(kmres4,xstd)

# --- no of clusters = 5 
kmres5 <- kmeans(xstd,centers=5,nstart=25)
fviz_cluster(kmres5,xstd)


# --- other CLUSTER CHARACTERISTICS
# --- cluster CENTERS
kmres3$centers
kmres4$centers
kmres5$centers

# --- cluster CENTER DISTANCES 
EuclideanDistance(kmres3$centers[1], kmres3$centers[2])
EuclideanDistance(kmres3$centers[1], kmres3$centers[3])
EuclideanDistance(kmres3$centers[2], kmres3$centers[3])

ManhattanDistance(kmres3$centers[1], kmres3$centers[2])


# ----------------------------------------------------
# --- OPTIMAL NUMBER OF CLUSTERS
# --- The ELBOW Method 
# ----------------------------------------------------
set.seed(12345)

# --- Step 1
# --- Compute and plot for cluster no k = 2 to k = 15
# --- Using Intra Cluster Measure "Sum of Squares"
k.max <- 15
data <- xstd
tot_wss <- sapply(1:k.max, 
              function(k){kmeans(data, k, nstart=50,iter.max = 15 )$tot.withinss})
tot_wss

# --- Step 2
# --- Visualize kMeans metric tot.withinss for all k
par(mfrow=c(1,1)) 
plot(1:k.max, tot_wss,
     type="b", pch = 19, frame = FALSE, 
     xlab="Number of clusters [K]",
     ylab="Total within-clusters sum of squares [tot.withinss]")


# --------------------------------------------------
# --- OTHER CLUSTERING Algorithms
# --- k-medoids cluster algorithm
# --- (PAM = partitioning around medoids)


# --- no of clusters = 2
pamres2 <- pam(xstd, 2)
View(pamres2)

# --- no of clusters = 3,4,5
pamres3 <- pam(xstd, 3)
pamres4 <- pam(xstd, 4)
pamres5 <- pam(xstd, 5)

# --- Cluster Characteristics
# --- for clusters = 3
View(pamres3)
pamres3$medoids
pamres3$clustering
pamres3$clusinfo

# --- Visualize Cluster calculations
fviz_cluster(pamres2,xraw)
fviz_cluster(pamres3,xraw)
fviz_cluster(pamres4,xraw)
fviz_cluster(pamres5,xraw)

# --- Add CLASSIFICATIONS to the original data
xraw_pamcl3 <- cbind(USArrests, cluster = pamres3$cluster)
xraw_pamcl3


# ----------------------------------------------------
# --- OPTIMAL NUMBER OF CLUSTERS
# --- with fviz_nbclust method of library "factoextra"
# ----------------------------------------------------
# --- optimal number of clusters
set.seed(12345)
fviz_nbclust(xstd, kmeans, method="wss")
fviz_nbclust(xstd, kmeans, method="silhouette")
fviz_nbclust(xstd, kmeans, method="gap_stat")

fviz_nbclust(xstd, pam, method="wss")
fviz_nbclust(xstd, pam, method="silhouette")

