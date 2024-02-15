# --- ----------------------------------------------------------------------
# --- Linear Nonlinear REGRESSION Example
# --- 
# --- (c) May 2021, D.Benninger
# ---  
# ---
# --- Libraries: stats, fpp, ggplot2
# ---            splines, pmml
# ---
# --- Data:  DATA_Werbung.csv    
# ---
# --- Links
# ---   https://www.kaggle.com/ashydv/advertising-dataset
# ---   https://rpubs.com/amitnke/lrad
# ---   
# ---
# --- Version
# ---    V1 May 2021 dbe - adapted from Gwen Wilke's example for CAS DA4
# ---    V2 May 2021 dbe - Error corrections, PMML model export added
# ---                      nonlinear regression models (poly, splines) added
# --- ----------------------------------------------------------------------

# Set WORKING Directory
# setwd(choose.dir())
# getwd()

# --- Packages installieren, falls nicht vorhanden
if(!"stats" %in% rownames(installed.packages())) install.packages("stats")
if(!"fpp" %in% rownames(installed.packages())) install.packages("fpp")
if(!"ggplot2" %in% rownames(installed.packages())) install.packages("ggplot2")

# --- Packages laden
library("stats")


# ------------------------------------------------
# --- DATA Load, Overview and Statistical Summary
# ------------------------------------------------
# --- load data Advertising
Werbung <- read.csv("DATA_Werbung.csv")

# explore dataset

View(Werbung)
str(Werbung)
summary(Werbung)

summary(Werbung$Sales)

# show histograms
hist(Werbung$Sales, n=20)           
hist(Werbung$TV, n=20)
hist(Werbung$Radio, n=20)
hist(Werbung$Newspaper, n=20)

# show pairwise scatterplots for all features
pairs(Werbung)   
# alternative via plot function
plot(Werbung) 


# statistical exploration - boxplot,quantile,correlation
summary(Werbung)

boxplot(Werbung$Sales,main="Boxplot Sales")  
quantile(Werbung$Sales)
boxplot(Werbung$Newspaper, main="Boxplot Radio Advertising")  
quantile(Werbung$Newspaper) 
 
cor(Werbung$TV,Werbung$Sales)       # correlation coefficient
cor.test(Werbung$TV,Werbung$Sales)  # hypothesis test for correlation
   

# ------------------------------------------------
# --- VISUAL exploration
# ------------------------------------------------
   
# --- a single Scatterplot 
plot(Sales ~ TV, data=Werbung) 
plot(Sales ~ Radio, data=Werbung)
plot(Sales ~ Newspaper, data=Werbung)
 
 
# --- all in one picture
 par(mfrow=c(1,3))
   plot(Sales ~ TV, data=Werbung)
   plot(Sales ~ Radio, data=Werbung)
   plot(Sales ~ Newspaper, data=Werbung)
 par(mfrow=c(1,1))
 
# --- beautified with title, color and plotting character (pch)
 par(mfrow=c(1,3))
   plot(Sales ~ TV, data=Werbung, main="TV", col="red", pch=20) 
   plot(Sales ~ Radio, data=Werbung, main="TV", col="blue", pch=20)
   plot(Sales ~ Newspaper, data=Werbung, main="TV", col="green", pch=20)
 par(mfrow=c(1,1))
   
 
# ------------------------------------------------
# --- Linear REGRESSION modelling
# ---
# --- Sample Feature "TV advertising"
# ------------------------------------------------ 

TVModell <- lm(Sales ~ TV, data=Werbung)

TVModell
View(TVModell)

# Scatterplot of feature TV 
plot(Sales ~ TV, data=Werbung, main="TV", col="red", pch=20)
 
 # Add Regressionline for TV within the scatterplot
abline(TVModell, col="blue")
 
# ------------------------------------------------
# --- Regressionline for all advertising features
# --- using the "fitting linear model (lm)" function
# -----------------------------------------------------
#     see "biglm" to fit linear models to large dataset, 
#         "glm" for generalized linear models
# ------------------------------------------------ 

# --- using linear model (lm) function
TVModell <- lm(Sales ~ TV, data=Werbung)     
RadioModell <- lm(Sales ~ Radio, data=Werbung)
NewspaperModell <- lm(Sales ~ Newspaper, data=Werbung)
 
# All scatterplots with regressionlines
 par(mfrow=c(1,3))
 
   plot(Sales ~ TV, data=Werbung, col="red", pch=20)
   abline(TVModell, col="black")
   
   plot(Sales ~ Radio, data=Werbung, col="blue", pch=20)
   abline(RadioModell, col="black")
   
   plot(Sales ~ Newspaper, data=Werbung, col="green", pch=20)
   abline(NewspaperModell, col="black")
 
 par(mfrow=c(1,1))
 
 
# ------------------------------------------------
# --- PREDICTION values for new data
# ------------------------------------------------ 

# new data points: e.g. TV-Budgets without any Sales Volumes
# Tipp: Using brackets for the entire command, adds the result to te variable AND displays the variable on the console prompt
(newDataTV <- data.frame(TV=c(3,100,275, 350))) 				

# calculate the (Sales) prediction for the new data points
(mySalesPredictionTV <- predict(TVModell, newDataTV))
   
# build new (predicted) value pairs (TV ads ~ Sales pred)
# and draw these value pairs 
(mydata <- cbind(newDataTV, mySalesPredictionTV))     
plot(mydata, col="red", pch=23,cex=1.5)               

# combine the prediction with the given (historical) data and the calculated regression line   
   plot(Sales ~ TV, data=Werbung, col="blue", pch=20)
   abline(TVModell, col="black")
   points(mydata, col="red", pch=23, cex=1.5)
   
# we need to adjust the x-axis, as a TV-Budget of 350 lies outside the given data 
   plot(Sales ~ TV, data=Werbung, col="blue", pch=20, xlim=c(0,400), ylim=c(0,25))   
   abline(TVModell, col="black")
   points(mydata, col="red", pch=23, cex=1.5)   # noe we see all 4 predicted value pairs :-)

   
# ------------------------------------------------
# --- QUALITY MEASURES of the PREDICTION 
# --- Residual Analysis
# ------------------------------------------------    
   
# summary function, applied to our modell returns quality measure information 
#     - determination measure (Bestimmtheitsmass) = "Multiple R-squared"
#     - residual error (Residual Fehlerschäzer)  = "Residual Standard Error"
   
 summary(TVModell)
 
# using the confint command e.g. with parameter level=0.95, returns the 95%-confidence interval of the coefficients
 confint(TVModell, level=0.95)
   
  
# the confidence intervall for the PREDICTED values of the NEW data points
  predict(TVModell, interval = "confidence", newDataTV, level=0.95)
 
# the prediction intervall for the PREDICTED values
  predict(TVModell, interval = "prediction", newDataTV, level=0.95)
 
# 95%- und 99%-Prognoseintervall der Vorhersage plotten
  library(fpp)
  plot(forecast(TVModell, newdata=newDataTV))
 
# Confidence and Prediction interval for ALL (historical TRAINING) data points
# PREDICTION for all training data points
  (SalesPredictionTV_PI <- predict(TVModell, interval = "prediction", level=0.95))  

# adding the prediction to the TV data points
  (myDataTV_PI <- as.data.frame(cbind(TV=Werbung$TV, Sales=Werbung$Sales, SalesPredictionTV_PI))) 
   
# plotten the intervals and the trainings data points
  library(ggplot2)
  p <- ggplot(myDataTV_PI, aes(TV, Sales)) + 
     labs( title = "Linear Regression Model for TV Advertising and Sales Volume",
           subtitle = "Trainingsdata, Linear Model and the corresponding Confidence/Prediction Intervals",
           caption = "Data source: DATA_Advertising.csv") +
     geom_point() +
     stat_smooth(method = lm)
   
  p + geom_line(aes(y = lwr), color = "red", linetype = "dashed")+
     geom_line(aes(y = upr), color = "red", linetype = "dashed")
   

# ---------------------------------------------------------------------------------------
# --- NON-LINEAR REGRESSION modelling
# --- **Polynomial** Regression
# --- Sample Feature "TV advertising"
# ------------------------------------------------ 

# --- using "polynomial" (poly) function of order 2 
  TVModell_poly <- lm(Sales ~ poly(TV, 2, raw=TRUE), data=Werbung)
  
  TVModell_poly
  View(TVModell_poly)
  
# --- calculate predicted data
  TVModell_poly_predict <-predict(TVModell_poly)

# --- scatterplot of (original) feature TV 
  plot(Sales ~ TV, data=Werbung, main="TV", col="red", pch=20)

# --- add polyline for (predicted) feature values within the scatterplot
  ix <- sort(Werbung$TV,index.return=T)$ix
  lines(Werbung$TV[ix], TVModell_poly_predict[ix], col="blue")  
  

# ------------------------------------------------
# --- Non-Linear REGRESSION modelling
# --- **Spline** Regression
# --- Sample Feature "TV advertising"
# ------------------------------------------------ 
  if(!"splines" %in% rownames(installed.packages())) install.packages("splines")
  library("splines")

# --- using "splines" (bs) function with knot points at values 50,150 and 200 (alternatively: use quartiles for split knots)   
  TVModell_spline <- lm(Sales ~ bs(TV, knots=c(50,150,200)), data=Werbung)
  
  TVModell_spline
  View(TVModell_spline)

  # --- calculate predicted data
  TVModell_spline_predict <-predict(TVModell_spline)
  
  # --- scatterplot of (original) feature TV 
  plot(Sales ~ TV, data=Werbung, col="black", pch=20)
  
  # --- add spline line for (predicted) feature values within the scatterplot
  ix <- sort(Werbung$TV,index.return=T)$ix
  lines(Werbung$TV[ix], TVModell_spline_predict[ix], col="green", lw=2)  
  
  # --- add polynomial and linear regression model predictions as well
  lines(Werbung$TV[ix], TVModell_poly_predict[ix], col="blue", lw=2)  
  abline(TVModell, col="red", lw=2)
  
  title("WERBUNG: Gemessene Daten, Regressionsmodelle (lin,poly, spline)")
  legend("topleft", c("linear", "polynomial", "splines"), col=c("red","green","blue"), lty=c(1,1,1))
  
# ---------------------------------------
# EXPORT the resulting models as PMML files
# -----------------------------------------
if(!"pmml" %in% rownames(installed.packages())) install.packages("pmml")
library("pmml")

file_TVModell <- "MODEL_TVWerbung_prediction.xml"
saveXML(pmml( TVModell, model.name = "Werbung-TV-Prediction-Modell_lm"),file = file_TVModell)
   
file_RadioModell <- "MODEL_RadioWerbung_prediction.xml"
saveXML(pmml( RadioModell, model.name = "Werbung-RADIO-Prediction-Modell_lm"),file = file_RadioModell)

file_NewspaperModell <- "MODEL_NewspaperWerbung_prediction.xml"
saveXML(pmml( NewspaperModell, model.name = "Werbung-NEWSPAPER-Prediction-Modell_lm"),file = file_NewspaperModell)
