library(openair)
library(ggplot2)
library(readr)
library(dplyr)
library(data.table)
library(rio)
library(zoo)
library(tidyverse)
library(lubridate)
setwd('C:/Users/PC/OneDrive/Documents/data')
 data <- read.csv('SUMMER_DATA.csv')
 
 ##Select sign with dollar
 data$date_time <- lubridate::mdy_hm(data$date_time)
 data <- cutData(data, type = 'season') ##creating a column for season

 data = rename(data, date= date_time)
 
 summaryPlot(data)
 
 timeVariation(data, pollutant = c('pm25', 'temp'))
 
 polarPlot(data, pollutant= 'pm25')
 png('polar25.png')
 dev.off()
 
 polarFreq(data, pollutant = 'pm25', type = 'year', statistic = 'mean', min.bin = 2)
 
 polarCluster(data, pollutant = 'pm10', n.clusters = 2:10, cols = 'Set2')
 
calendarPlot(data, pollutant = 'pm10', year = 2020)
calendarPlot(data, pollutant = 'pm10', year = 2020, annotate = 'ws')
TheilSen(data, pollutant = 'pm25', ylab = 'pm2.5 (mg/m3)', deseason = TRUE)
 
TheilSen(data, pollutant = 'pm10', type = 'wd', ylab = 'pm10 (mg/m3)', deseason = TRUE)

smoothTrend(data, pollutant = c('pm25', 'pm10'), type = c('wd', 'season'), date.breaks = 3, lty = 0)

scatterPlot(data, x = 'pm25', y = 'pm10', method = 'hexbin', cols = 'jet')

scatterPlot(selectByDate(data, year = '2020'), x = 'pm25', y = 'pm10', method = 'density', cols = 'jet')
