# --- ----------------------------------------------------------------------
# --- TIME SERIES Analytics (and forecasting with ARIMA)
# ---
# --- (c) June 2017, dbe		- initial version
# --- V3  June 2019, dbe    - extended in R coding
# --- V4  June 2020, dbe		- minor extensions and bugfixing
# --- V5  May  2021, dbe		- adapted for BINA FS21
# ---
# --- Libraries: tseries, forecast, ggplot2, ggfortify
# ---
# --- Data:      AirPassengers		(standard integrated time series dataset)
# ---
# --- Links:   https://rpubs.com/neharaut05/TimeSeries_AirPassangerForecast
# ---				https://www.r-graph-gallery.com/time-series.html
# ---				https://rpubs.com/emb90/137525
# ---          http://bit.ly/2X7YnSq
# ---
# --- ----------------------------------------------------------------------
# Set WORKING Directory
# setwd(choose.dir())
# getwd()

# Packages installieren, falls nicht vorhanden
if(!"tseries" %in% rownames(installed.packages())) install.packages("tseries")
if(!"forecast" %in% rownames(installed.packages())) install.packages("forecast")
if(!"ggplot2" %in% rownames(installed.packages())) install.packages("ggplot2")
if(!"ggfortify" %in% rownames(installed.packages())) install.packages("ggfortify")

# Packages laden
library("tseries")
library("forecast")
library("ggplot2")
library("ggfortify")


# ---------------------------------------------------
# --- DATA Load, Overview and Explore
# ---------------------------------------------------
# --- Data AirPassengers
data("AirPassengers")

AirPassengers
str(AirPassengers)

# --- check for missing vaues, the class (ts) and frequency (12) of AirPassengers dataset
sum(is.na(AirPassengers))
class(AirPassengers)
frequency(AirPassengers)

# --- Statistical Summary and Visualization
summary(AirPassengers)

 boxplot(summary(AirPassengers), main="Boxplot: AirPassengers p.a.",ylim=c(0,700),ylab = "Passenger numbers (1000's)")

 plot(AirPassengers,xlab="Date", ylim=c(0,700),ylab = "Passenger numbers (1000's)", type="o", pch=20,main="Tim Series: Air Passenger numbers from 1949 to 1961")

 boxplot(AirPassengers~cycle(AirPassengers),xlab="Date", ylim=c(0,700), ylab = "Passenger Numbers (1000's)" ,main ="Boxplot: Monthly Air Passengers from 1949 to 1961")

# --- add month name axis labels
monthNames <- months(ISOdate(2011,1:12,1))
 axis(1, at=1:12, labels=monthNames, las=2)

# --- a rough initial linear regression model calculation
plot(AirPassengers,xlab="Date", ylim=c(0,700))+abline(reg=lm(AirPassengers~time(AirPassengers)), col="blue")


# --- ----------------------------------------
# --- TIMESERIES  ANALYSIS
# --- ----------------------------------------
# --- first decompose the time series data into the given 12 years (1949-1961)
years_AirPassengers <- ts(AirPassengers, frequency = 12)

# --- (standard) timeseries decomposition
stdDecomp_AirPassengers <- decompose(years_AirPassengers)
 plot(stdDecomp_AirPassengers)

# --- e.g. SEASONAL figures
stdDecomp_AirPassengers$figure
  plot(stdDecomp_AirPassengers$seasonal, main= "Time Series Decomposition: SEASONAL Part (all Years)", type="b",  xlab="Years", ylim=c(-100,100))
  plot(stdDecomp_AirPassengers$seasonal[1:12], main= "Time Series Decomposition: SEASONAL Part (1st Year)", type="b",  xlab="Months", ylim=c(-100,100))
  
# --- e.g. ALL time series COMPONENTS
par(mfrow=c(3,1))
 plot(stdDecomp_AirPassengers$trend, xlab="Years", ylim=c(0,700))				# the TREND
 plot(stdDecomp_AirPassengers$seasonal, xlab="Years", ylim=c(-100,100))		# the SAISONALITY
 plot(stdDecomp_AirPassengers$random, xlab="Years",ylim=c(-100,100))			# the NOISE
par(mfrow=c(1,1))

# --- first Year only
par(mfrow=c(3,1))
 plot(stdDecomp_AirPassengers$trend[1:12], type="l", xlab="Months", ylim=c(0,700))				# the TREND
 plot(stdDecomp_AirPassengers$seasonal[1:12], type="l",xlab="Months", ylim=c(-100,100))		# the SAISONALITY
 plot(stdDecomp_AirPassengers$random[1:12], type="l",xlab="Months",ylim=c(-100,100))			# the NOISE

 # --- get names of 12 months in English words
 monthNames <- months(ISOdate(2011,1:12,1))
 # --- label x-axis with month names, "las" is set to 2 for vertical label orientation
 axis(1, at=1:12, labels=monthNames, las=2)
par(mfrow=c(1,1))



# --------------------------------------------------------------
# --- Analysing the TREND Component
# --- inspecting the trend component in the decomposition plot 
# --- suggests that the relationship is linear, thus fitting a linear model

timeStampSerie <- seq(1, 144, 1)			# define a timestamp series for the dataset

# --- linear REGRESSION Model (lm model) for the TREND time series data
Trend_Model <- lm(formula = stdDecomp_AirPassengers$trend ~ timeStampSerie)

View(Trend_Model)
summary(Trend_Model)

# --- PREDICTION with lm model of the TREND time series for the timeStampSerie
Trend_Prediction <- predict.lm(Trend_Model, newdata = data.frame(timeStampSerie))

View(Trend_Prediction)

# --- visualizing the time series
 plot(stdDecomp_AirPassengers$trend[7:138] ~ t[7:138], ylab="Trend(t)", xlab="t",
      type="p", pch=20, main = "AirPassengers TREND Component: Modelled vs Observed")
 lines(Trend_Prediction, col="red")

layout(matrix(c(1,2,3,4),2,2))
 plot(Trend_Model, main="AirPassengers: Trend Model Metrics")

summary(Trend_Model)

# --------------------------------------------------------------
# --- Test AirPassengers time series for STATIONARITY
# --- using the augmented Dickey-Fuller Test
adf.test(AirPassengers)

# --- Test AUTOCORRELATION of AirPassengers time series
 plot(acf(AirPassengers,plot=FALSE),	main="AirPassengers: Correlogram of Time Series Data from 1949 to 1961")

# Autoplot the RANDOM (noise) time series from 7:138 which exclude the NA values
 plot(acf(stdDecomp_AirPassengers$random[7:138],plot=FALSE), main="AirPassengers: Correlogram of NOISE Time Series Data from 1949 to 1961")

# Autoplot the SAISONALITY (seasonal) time series from 7:138 which exclude the NA values
 plot(acf(stdDecomp_AirPassengers$seasonal[7:138],plot=FALSE), main="AirPassengers: Correlogram of SEASONAL Time Series Data from 1949 to 1961")

# --- plotting all acf diagrams in one picture
par(mfrow=c(3,1))
   plot(acf(AirPassengers,plot=FALSE),	main="AirPassengers: Correlogram of Time Series Data from 1949 to 1961")
   plot(acf(stdDecomp_AirPassengers$random[7:138],plot=FALSE), main="AirPassengers: Correlogram of NOISE Time Series Data from 1949 to 1961")
   plot(acf(stdDecomp_AirPassengers$seasonal[7:138],plot=FALSE), main="AirPassengers: Correlogram of SEASONAL Time Series Data from 1949 to 1961")
par(mfrow=c(1,1))
   
# ----------------------------------------------------------------
# --- Time Series FORECASTING with the ARIMA Model
# ---
# --- ARIMA = autoregressive integrated moving average
# --- ------------------------------------------------------------

# --- fit an ARIMA model to an univariate time series 
fit_AirPassengers <- arima(AirPassengers, order=c(1,0,0), list(order=c(2,1,0), period=12))

summary(fit_AirPassengers)
fit_AirPassengers
View(fit_AirPassengers)


# --- Perform MODEL DIAGNOSTICS
# --- The ggtsdiag function from ggfortify R package performs model diagnostics of the residuals 
# --- and the acf, including an autocovariance plot
ggtsdiag(fit_AirPassengers)

# --- and then use it for FORECASTING the next n=24 periods
forecast_AirPassengers <- predict(fit_AirPassengers, n.ahead = 24)

summary(forecast_AirPassengers)
forecast_AirPassengers
View(forecast_AirPassengers)

# --- calculate an upper and lower Band and and VISUALIZE the forecasted values within these bands
forecast_Upper <- forecast_AirPassengers$pred + 2*forecast_AirPassengers$se
forecast_Lower <- forecast_AirPassengers$pred - 2*forecast_AirPassengers$se

ts.plot(AirPassengers, forecast_AirPassengers$pred, forecast_Upper, forecast_Lower, 
        ylim=c(0,800), col=c(1,2,4,4), lty = c(1,1,2,2), xlab="Years", ylab="Passengers (in 1000's)")
 title("AirPassengers: Historical Data, Forecast and Confidence Intervals")
 legend("topleft", c("Actual", "Forecast", "Error Bounds (95% Confidence)"), col=c(1,2,4), lty=c(1,1,2))
 