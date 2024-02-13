## Regression + Time Series in Python
#### last update 14/4/23 dbe - more notebooks added for time series anaylsis and forecasting

![TimeSeriesChart_1](https://user-images.githubusercontent.com/52699611/168090912-1c907109-0ae1-442e-b2c3-fb4ea4e62963.jpg)

Any data recorded with some fixed interval of time is called as **time series data**. This fixed interval can be hourly, daily, monthly or yearly. e.g. hourly temp reading, daily changing fuel prices, monthly electricity bill, annul company profit report etc. In time series data, time will always be an *independent variable* and there can be one or many *dependent variable*.

**Time series forecasting** is the process of analyzing time series data using statistics and modeling to make predictions and inform strategic decision-making.  
It’s not always an exact prediction, and likelihood of forecasts can vary wildly—especially when dealing with the commonly fluctuating variables in time series data as well as factors outside our control.

There is a monthly time series data of the (international) **Air Passengers** of Pan Am airline in the United Stades of America from 1 Jan 1949 to 1 Dec 1960. Each row contains the air passenger number for a month of that particular year. The numbers were obtained from the Federal Aviation Administration. The company used the data to predict future demand before ordering new aircraft and training aircrew.  

### Python Notebooks for Regression + Time Series Analysis and Forecasting

* The [Advertising dataset](https://github.com/sawubona-gmbh/BINA-FS23-WORK/blob/2c1def124c2d61f211071641d0da9f2a7fc93fde/LB10-Regression+TimeSeries/Python/DATA_Werbung.csv) to analyse the relationship between 'TV advertising' and 'sales' using a simple [Linear Regression model](https://github.com/sawubona-gmbh/BINA-FS23-WORK/blob/2c1def124c2d61f211071641d0da9f2a7fc93fde/LB10-Regression+TimeSeries/Python/Python_Linear_REGRESSION_Advertising_v1.ipynb)

* Linear regression helps us establishing a relationship between a dependent variable and an independent variable and fitting a straight line through the data points.  In a [Spline Regression](https://github.com/sawubona-gmbh/BINA-FS23-WORK/blob/2bcbf38ca89a4dcbb2e98a4ab4b416f6353c77a0/LB10-Regression+TimeSeries/Python/Python_Regression_SPLINES_v2.ipynb) the whole dataset is divided into smaller bins and the (cubic) regression line is predicted for each bin and the separate lines are joined together smoothly by knots.

* See the classical [ARIMA based analysis and forecast](https://github.com/sawubona-gmbh/BINA-FS23-WORK/blob/b45d7c685c9b1827ba64a0f3b0e7e82aedcec472/LB10-Regression+TimeSeries/Python/Python_TIMESERIES_AirPassengers_v3.ipynb) and a novel approach using the [Darts time series forecasting](https://github.com/sawubona-gmbh/BINA-FS23-WORK/blob/b45d7c685c9b1827ba64a0f3b0e7e82aedcec472/LB10-Regression+TimeSeries/Python/Python_TIMESERIES_AirPassengers_withDarts.ipynb) library using the famous The [Air Passengers dataset](https://github.com/sawubona-gmbh/BINA-FS23-WORK/blob/b45d7c685c9b1827ba64a0f3b0e7e82aedcec472/LB10-Regression+TimeSeries/Python/DATA_AirPassengers.csv) of the US airline Pan Am from 1949 to 1960. 

* Find a [Time Series Analysis and Visualization of financial data](https://github.com/sawubona-gmbh/BINA-FS23-WORK/blob/73efd8e29f2402434da28a19b6bfc78a3211c49e/LB10-Regression+TimeSeries/Python/Python_TIMESERIES_FinancialData_v3.ipynb) using [Credit Suisse](https://github.com/sawubona-gmbh/BINA-FS23-WORK/blob/c9dd3d76d2b7f9102c9a86a9b2c4592fb10029ac/LB10-Regression+TimeSeries/Python/DATA-CS.csv) stock market data from 2009-2023

![Yahoo Finance CREDIT SUISSE](https://github.com/sawubona-gmbh/BINA-FS23-WORK/blob/777c6ef077583ceffedda5779702a786038f0385/LB10-Regression+TimeSeries/Python/Yahoo-CREDIT%20SUISSE_21-04-_2023.jpg)]

--- 
* see [Kaggle](https://www.kaggle.com/code/manas13/time-series-air-passenger/notebook) for another python notebook on Time Series with Air Passenger Data
* see [Analytics Vidhya](https://www.analyticsvidhya.com/blog/2021/10/a-comprehensive-guide-to-time-series-analysis/) for indepth discussion and explanation of Time Series analysis
* see [Kaggle](https://www.kaggle.com/code/zebashaikh/linear-regression-on-advertising-dataset/notebook) for another python notebook on Linear Regression with Advertising Data  
---   
