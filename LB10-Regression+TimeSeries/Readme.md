# LB10 - Regression + Time Series README
###### Last update: 14/4/23 dbe - added Tools + Examples description
</br>

![Folie4](https://user-images.githubusercontent.com/52699611/168085602-800c1f8a-1771-4bf1-a588-448af5cee539.PNG)


## A) Regression

![Basic-Non-Linear-Model](https://user-images.githubusercontent.com/52699611/168087475-9a8e1ad8-0e86-457d-86f1-6d7fa7abbb6b.jpg)


**Regression Analysis** is the study of dependence: how does a response variable change as the values of one or more predictor variables are changed? In statistical modeling, Regression Analysis is a set of statistical processes for estimating the relationships between a dependent variable (often called the *outcome* or *response* variable) and one or more independent variables (often called *predictors*, *covariates*, *explanatory variables* or *features*). The most common form of Regression Analysis is *Linear Regression*, in which one finds the *line* (or a more complex linear combination) that most closely fits the data according to a specific mathematical criterion. For example, the method of ordinary least squares computes the unique line (or hyperplane) that *minimizes the sum of squared differences* (*residuals*) between the true data and that line (or hyperplane).

* see the [StatQuest Tutorial](https://youtu.be/nk2CQITm_eo) of Josh Starmer from xxxx on the **Linear Regression** technique. 
* have a look also at the [R Code step-by-step](https://youtu.be/u1cc1r_Y7M0) explanation of Josh Starmer    
</br>


## B) Time Series

![1_sT8uHuUVZ-7OnowqXugn0A](https://user-images.githubusercontent.com/52699611/168086108-6b1e8fb9-77e6-4832-acfc-49d99a575356.png)


**Time Series Data**, also referred to as time-stamped data, is a sequence of data points indexed in time order. Time-stamped is data collected at different points in time. Whether we wish to predict the *trend* in financial markets or electricity consumption, time is an important factor that must now be considered in our models. For example, it would be interesting to *forecast* at what hour during the day is there going to be a peak consumption in electricity, such as to adjust the price or the production of electricity. These data points typically consist of successive measurements made from the same source over a time interval and are used to track change over time.

* see [Towards Data Science](https://towardsdatascience.com/the-complete-guide-to-time-series-analysis-and-forecasting-70d476bfe775) for a complete guide on time series analysis and forecasting.   
* see [SimpliLearn](https://www.simplilearn.com/tutorials/data-science-tutorial/time-series-forecasting-in-r) for a complete guide to Time Series Forecasting in R
</br>



## C) Tools and Examples  

Find the following Python Notebooks dealing with *linear regression*, *time series analysis* or *time series forecasting* using appropriate Python libraries   

* The [Advertising dataset](https://github.com/sawubona-gmbh/BINA-FS23-WORK/blob/2c1def124c2d61f211071641d0da9f2a7fc93fde/LB10-Regression+TimeSeries/Python/DATA_Werbung.csv) to analyse the relationship between 'TV advertising' and 'sales' using a simple [Linear Regression model](https://github.com/sawubona-gmbh/BINA-FS23-WORK/blob/2c1def124c2d61f211071641d0da9f2a7fc93fde/LB10-Regression+TimeSeries/Python/Python_Linear_REGRESSION_Advertising_v1.ipynb) which predicts sales based on the money spent on different platforms for marketing.

* Linear regression helps us establishing a relationship between a dependent variable and an independent variable and fitting a straight line through the data points. But, in real-world data science, linear relationships between data points is a rarity. To overcome this, polynomial regression was introduced. But the main drawback of this was the increased complexity of the algorithm and it became difficult to handle them eventually leading to overfitting of the model. To further eliminate these drawbacks, [Spline Regression](https://github.com/sawubona-gmbh/BINA-FS23-WORK/blob/2bcbf38ca89a4dcbb2e98a4ab4b416f6353c77a0/LB10-Regression+TimeSeries/Python/Python_Regression_SPLINES_v2.ipynb) was introduced. 

* Financial analysts often use time-series data to make investment decisions. A **time series** is a set of observations on a variable's outcomes in different time periods: the quarterly sales for a particular company during the past five years, for example, or the daily returns on a traded security. Find the [Time Series Analysis and Visualization of financial data](https://github.com/sawubona-gmbh/BINA-FS23-WORK/blob/73efd8e29f2402434da28a19b6bfc78a3211c49e/LB10-Regression+TimeSeries/Python/Python_TIMESERIES_FinancialData_v3.ipynb) for [Credit Suisse](https://github.com/sawubona-gmbh/BINA-FS23-WORK/blob/c9dd3d76d2b7f9102c9a86a9b2c4592fb10029ac/LB10-Regression+TimeSeries/Python/DATA-CS.csv) stock market data from 2009-2023

* The [Air Passengers dataset](https://github.com/sawubona-gmbh/BINA-FS23-WORK/blob/b45d7c685c9b1827ba64a0f3b0e7e82aedcec472/LB10-Regression+TimeSeries/Python/DATA_AirPassengers.csv) gives information of monthly passengers totals of a US airline (Pan Am) from 1949 to 1960. The dataset is widely used in time series analysis and forecsting showcases, using suitable time series models to forecasts the number of passengers for the next 24 months. See the classical [ARIMA based analysis and forecast](https://github.com/sawubona-gmbh/BINA-FS23-WORK/blob/b45d7c685c9b1827ba64a0f3b0e7e82aedcec472/LB10-Regression+TimeSeries/Python/Python_TIMESERIES_AirPassengers_v3.ipynb) and a novel approach using the [Darts time series forecasting](https://github.com/sawubona-gmbh/BINA-FS23-WORK/blob/b45d7c685c9b1827ba64a0f3b0e7e82aedcec472/LB10-Regression+TimeSeries/Python/Python_TIMESERIES_AirPassengers_withDarts.ipynb) library from [Unit8](https://unit8.com/) a swiss data services company



