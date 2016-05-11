if(!exists("retail", mode="any")) source("/Users/briggsmilburn/Desktop/retail/retail_data.r")

library(forecast)

## Objective: 
## 	Identify patterns in the data - stationarity/non-stationarity
## 	Prediction from previous patterns

## Problem Statement: Forecast sales for 2013
p <- subset(price1,!is.na(date))
p_ts <- select(p, date, quantity)

ts <- ts(t(p_ts[,1:2]))
plot(ts,type='o',col='blue')