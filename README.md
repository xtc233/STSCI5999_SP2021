# STSCI5999_SP2021

Soildata = read.csv('Soil Moisture.csv')

# to get a new dataframe that contains only Region, Date and Value
soil = data.frame(Region = Soildata$Region,
                      Date = as.Date(Soildata$End.Date),
                      Value = as.numeric(Soildata$Value))
soil = na.omit(soil)

# plot 
Date = as.factor(soil_s$Canada$Date)
plot(Date,soil_s$Canada$Value)

# split the data frame by Regions
soil_s = split(soil,soil$Region)


install.packages('tidyverse')
install.packages('xts')
library(xts)
library(dplyr)
library(lubridate)

# to get the monthly average value
soil %>%
  mutate(year = year(Date), 
         monthnum = month(Date),
         month = month(Date, label=T)) %>%
  group_by(year, month) %>%
  arrange(year, monthnum) %>%
  select(-monthnum) %>%
  summarise(Value = mean(Value))
