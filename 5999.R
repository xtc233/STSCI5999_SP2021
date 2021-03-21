# Load data, summary, boxplot
soildata <- read.csv("Availability in soil(volume-volume)-soil moisture.csv")
summary(soildata)

# Redefine the dataframe, remove null
soil <- soildata
soil = data.frame(soil$Region,soil$End.Date,soil$Value)
soil <- na.omit(soil)
soil

# Split the data and name them with the region name
soil_s <- split(soil, soil$soil.Region)
soil_s

# Change data type
soil$soil.End.Date <- as.Date(soil$soil.End.Date)
soil$soil.Region <- as.character(soil$soil.Region)
soil$soil.Value <- as.numeric(as.character(soil$soil.Value))
soil <- na.omit(soil)
soil

# Change to monthly avg
library(xts)
library(dplyr)
library(lubridate)

# Dataset
soil <- subset(soil, select=c(soil.Region, soil.End.Date, soil.Value))
soil <- soil %>%
  mutate(year = year(soil.End.Date), 
         monthnum = month(soil.End.Date),
         month = month(soil.End.Date, label=T)) %>%
  group_by(soil.Region, year, month) %>%
  arrange(year, monthnum) %>%
  select(-monthnum) %>%
  summarise(soil.Value = mean(soil.Value))
soil


