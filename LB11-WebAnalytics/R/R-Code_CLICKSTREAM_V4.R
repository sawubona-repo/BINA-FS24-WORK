# --- ----------------------------------------------------------------------
# --- CLICKSTREAM ANALYTICS with MARKOV CHAINS 
# --- ----------------------------------------
# --- (c) June 2018, D.Benninger
# --- june  2018, dbe		- initial version for CAS DA1 demo
# --- march 2019, dbe		- extended and adapted for CAS DA2
# --- may   2020, dbe   - (v3) extended and adapted for CAS DA3
# --- may   2021, dbe   - (v4) minor corrections for CAS DA4
# ---
# --- Libraries: 
#       clickstream, ggplot2
#       arulesSequences                     for click stream sequence patterns
# 
# --- Data:      
#       DATA_sampleSesssion.csv et.al.      small sample dataset
#       xxx                                 large generated sample dataset
#
# --- Links
#       https://xxxxxxx
# --- ----------------------------------------------------------------------

# --- check and set WORKING DIRECTORY Directory 
#     note: use "/" instead of "\"
#     not relevant for rstudio.cloud
# setwd("c:/<your working directory orfolder>")
setwd(choose.dir())
getwd()

# --- ---------------------------------------------------------
# --- Installation and/or Initialisation of necessary Libraries
# --- ---------------------------------------------------------
if(!"clickstream" %in% rownames(installed.packages())) install.packages("clickstream")
if(!"ggplot2" %in% rownames(installed.packages())) install.packages("ggplot2")
if(!"arulesSequences" %in% rownames(installed.packages())) install.packages("arulesSequences")

library("clickstream")
library("ggplot2")


# --- ----------------------------------------
# --- LOAD DATA from the working directory
# --- ----------------------------------------

# --- small sample set
xSampleClicks <- readClickstreams(file = "DATA_smallsampleClickstream.txt", sep = ";", header = TRUE)

# --- large generated sample set
# xLargeSampleClicks <- readClickstreams(file = "DATA_largesampleClickstream.csv", sep = ",", header = TRUE)
# head(xLargeSampleClicks)
# xSampleClicks <- xLargeSampleClicks

# --- Inspect the clickstream data
xSampleClicks
View(xSampleClicks)
str(xSampleClicks)
summary(xSampleClicks)


# --- ----------------------------------------
# --- Store clickstream data as file
# --- ----------------------------------------
writeClickstreams(xSampleClicks, "Z:/DATA_smallsample.csv", header = TRUE, sep = ";")


summary(xSampleClicks)

# --- ---------------------------------------------
# --- Calculate FREQUENCIES within clickstream data
# --- ---------------------------------------------
freq_xSampleClicks <- frequencies(xSampleClicks)

# --- Inspect the clickstream frequency 
freq_xSampleClicks
str(freq_xSampleClicks)
View(freq_xSampleClicks)
summary(freq_xSampleClicks)

# writeClickstreams(freq_xSampleClicks, "Z:/DATA_smallsample_frequencytable.csv", header = TRUE, sep = ";")

# par(mfrow=c(1,2)) 
# boxplot(summary(freq_xSampleClicks[,5]), main = "Defer")
# boxplot(summary(freq_xSampleClicks[,10]), main = "Buy")


# --- ----------------------------------------
# --- Fitting a MARKOV CHAIN MODEL 
# --- ----------------------------------------
xMarkovChain <- fitMarkovChain(clickstreamList = xSampleClicks, order = 2, 
                               control = list(optimizer = "quadratic"))

# --- Inspect the Markov Chain Model
xMarkovChain
View(xMarkovChain)
summary(xMarkovChain)


# --- ----------------------------------------
# --- PLOT TRANSITION matrix
# --- ----------------------------------------
# --- raw plot of the Markov Chain Model
plot(xMarkovChain)
plot(xMarkovChain, order =1)
plot(xMarkovChain, order =2)

# --- BEAUTIFY the Markov Chain Model Plot ---
# --- label color+distance, vertex size, edge size
plot(xMarkovChain, vertex.label.color="red", vertex.label.dist=1, vertex.size=7, edge.arrow.size=0.5)

# --- edge size+curvature, vertex shape
plot(xMarkovChain, vertex.label.color="red", vertex.label.dist=1, vertex.size=7, edge.arrow.size=0.5, edge.curved=TRUE, vertex.shape="sphere", edge.label.color="black")

# --- diagram title/subtitle
plot(xMarkovChain, vertex.label.color="red", vertex.label.size=5, vertex.label.dist=1, vertex.size=5, 
     edge.arrow.size=0.25, edge.curved=TRUE, 
     main="Markov Chain Transition Matrix", sub="CAS DA / Large Clickstream Sample")



# --- -----------------------------------------------------------------
# --- CLUSTERING clickstream sessions
# ---------------------------------------------------------------------
# split clickstream sessions prior into several clusters 
# to apply Markov Chain Modeling on a Subset of the initial (full) data
# --- -----------------------------------------------------------------

# --- Split into 3 CLUSTER, using k-Means Algorithm
cluster_xSampleClicks <- clusterClickstreams(clickstreamList = xSampleClicks, 
                                             order = 1, centers = 3)

# --- selecting a different kmeans algorithm implementation, and setting the max iteration cycle parameter
# cluster_xSampleClicks <- clusterClickstreams(clickstreamList = xSampleClicks, order = 1, centers = 3, 
#                                 algorithm="MacQueen", iter.max=10)

# Inspect clustered clickstream data
cluster_xSampleClicks

View(cluster_xSampleClicks)
summary(cluster_xSampleClicks)

# --- 1st cluster sessions
cluster_xSampleClicks$clusters[1]
# --- 2nd cluster sessions
cluster_xSampleClicks$clusters[2]
# --- 3rd cluster sessions
cluster_xSampleClicks$clusters[3]


# --- --------------------------------------------------
# --- Apply MARKOV CHAIN MODEL model for a single Custer 
# --- --------------------------------------------------
# --- extract 1st (1) cluster data
singlecluster_xSampleClicks <- cluster_xSampleClicks$clusters[1]

# --- fitting Markov chain model for a single CLUSTER  1
xMarkovChain_cluster <- fitMarkovChain(clickstreamList = singlecluster_xSampleClicks, order = 2, 
                         control = list(optimizer = "quadratic"))

# --- Inspect the Markov Chain Model
xMarkovChain_cluster
View(xMarkovChain_cluster)
summary(xMarkovChain_cluster)

# --- Plot the (cluster) Markov Chain Model
plot(xMarkovChain_cluster, vertex.label.color="red", vertex.label.dist=4, vertex.size10, 
     edge.arrow.size=0.5, 
     main="Markov Chain Transition Matrix - For a Single Subcluster",
     sub="CAS DA / LARGE Clickstream Sample")




# --- ------------------------------------------------------------------
# --- Supplement: PREDICTING (NEXT) CLICKS
# --- calculating Minimal SEQUENCE PATTERNS with aRulesSequences Library
# ---
# --- see Association Ruling in Machine Learning for more information
# --- ------------------------------------------------------------------

# --- load library
library("arulesSequences")

# --- TRANSFORM clickstream data
transformed_xSampleClicks <- as.transactions(xSampleClicks)

# --- Inspect transformed clickstream data
transformed_xSampleClicks
View(transformed_xSampleClicks)

# --- Extracting CLICK SEQUENCE PATTERNS 
# --- (e.g. with a minmal support gt. 0.4)
sequence_xSampleClicks <- as(cspade(transformed_xSampleClicks, 
                              parameter=list(support=0.2)), "data.frame")

# --- Inspect click sequence patterns
sequence_xSampleClicks
View(sequence_xSampleClicks)
str(sequence_xSampleClicks)
summary(sequence_xSampleClicks)

