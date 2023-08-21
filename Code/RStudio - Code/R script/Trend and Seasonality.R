library(lubridate)
library(dplyr)
library(forecast)
library(ggplot2)
library(scales)

# Import data-------------------------------------------------------------------
station1 <- read.csv("D:/RStudio/data/station1.csv")
station2 <- read.csv("D:/RStudio/data/station2.csv")
station3 <- read.csv("D:/RStudio/data/station3.csv")
station4 <- read.csv("D:/RStudio/data/station4.csv")
weather <- read.csv("D:/RStudio/data/weather.csv")

# Traffic trend and seasonality-----------------------------------------------------------

theme_update(plot.title = element_text(hjust = 0.5))

# Seasonality at station 1
station1$Datetime <- ymd_hms(station1$Datetime)
msts_station1<-station1$Total %>% msts( seasonal.periods = c(24, 24*7))
msts_station1 %>% mstl() %>% autoplot(main = 'Phân rã mùa vụ tại station1')
# %>% head(  24 *7 *4 ) 

# Seasonality at station 2
station2$Datetime <- ymd_hms(station2$Datetime)
msts_station2<-station2$Total %>% msts( seasonal.periods = c(24, 24*7))
msts_station2 %>% mstl() %>% autoplot(main = 'Phân rã mùa vụ tại station2')

# Seasonality at station 3
station3$Datetime <- ymd_hms(station3$Datetime)
msts_station3<-station3$Total %>% msts( seasonal.periods = c(24, 24*7))
msts_station3 %>% mstl() %>% autoplot(main = 'Phân rã mùa vụ tại station3')

# Seasonality at station 4
station4$Datetime <- ymd_hms(station4$Datetime)
msts_station4<-station4$Total %>% msts( seasonal.periods = c(24, 24*7))
msts_station4 %>% mstl() %>% autoplot(main = 'Phân rã mùa vụ tại station4')

# Weather trend and seasonality-----------------------------------------------------------
weather$Datetime <- ymd_hms(weather$Datetime)

# rain

ts_rain<-weather$rain %>% ts(frequency = 24)
ts_rain %>% stl(s.window = 'periodic') %>% autoplot(main = 'Phân rã mùa vụ rain')

# temp

ts_temp<-weather$temp %>% ts(frequency = 24)
ts_temp %>% stl(s.window = 'periodic') %>% autoplot(main = 'Phân rã mùa vụ temp')

# wetb

ts_wetb<-weather$wetb %>% ts(frequency = 24)
ts_wetb %>% stl(s.window = 'periodic') %>% autoplot(main = 'Phân rã mùa vụ wetb')

# dewpt

ts_dewpt<-weather$dewpt %>% ts(frequency = 24)
ts_dewpt %>% stl(s.window = 'periodic') %>% autoplot(main = 'Phân rã mùa vụ dewpt')

# vappr

ts_vappr<-weather$vappr %>% ts(frequency = 24)
ts_vappr %>% stl(s.window = 'periodic') %>% autoplot(main = 'Phân rã mùa vụ vappr')

# rhum

ts_rhum<-weather$rhum %>% ts(frequency = 24)
ts_rhum %>% stl(s.window = 'periodic') %>% autoplot(main = 'Phân rã mùa vụ rhum')

# msl

ts_msl<-weather$msl %>% ts(frequency = 24)
ts_msl %>% stl(s.window = 'periodic') %>% autoplot(main = 'Phân rã mùa vụ msl')