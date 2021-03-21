library("lubridate")

### Read data in CSV, store in data frame
datapath = "D:\\E-Angel\\Documents\\RStudio\\STSCI5999\\STSCI5999_SP2021\\Precipitation Quantity - Rainfall - Canada.csv"
rainfall <- read.csv(datapath)

rainfall_df <- data.frame(rainfall)
rainfall_subset <- data.frame(rainfall_df$Region ,rainfall_df$End.Date, rainfall_df$Value)


### data cleaning, summary
# Rename the dataset
names(rainfall_subset)[names(rainfall_subset) == "rainfall_df.Region"] <- "Region"
names(rainfall_subset)[names(rainfall_subset) == "rainfall_df.End.Date"] <- "End.Date"
names(rainfall_subset)[names(rainfall_subset) == "rainfall_df.Value"] <- "Value"

# Remove null
rainfall_subset <- na.omit(rainfall_subset) 
head(rainfall_subset)

# Monthly average
#Plan: make a monthly average of all data within that month, keep regions. Create a new data frame for this.
rainfall_subset$End.Date <- ymd(rainfall_subset$End.Date)
rainfall_subset$month <- month(rainfall_subset$End.Date)
rainfall_subset$year <- year(rainfall_subset$End.Date)

# Create montly aggregated data frame.
rainfall_month <- aggregate(as.numeric(Value) ~ Region + month + year, data = rainfall_subset, mean)
names(rainfall_month)[names(rainfall_month) == "as.numeric(Value)"] <- "Value"

### plot
library("tidyverse")
#ggplot(rainfall_month)
plot((rainfall_subset$Value[rainfall_subset$Region == "Canada"]), xaxt="n", type="o")
#((rainfall_month$Value[rainfall_month$Region == "Canada"]), col = "red", xaxt="n", type="o")
