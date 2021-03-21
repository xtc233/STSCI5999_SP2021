library("lubridate")

### Read the csv file

datapath = "D:\\E-Angel\\Documents\\RStudio\\STSCI5999\\STSCI5999_SP2021\\Yield(mass-area)-Canola.csv"
yield <- read.csv(datapath)

yield_df <- data.frame(yield)
yield_subset <- data.frame(yield_df$Region, yield_df$End.Date, yield_df$Value)

### data cleaning, summary
# Rename the dataset
names(yield_subset)[names(yield_subset) == "yield_df.Region"] <- "Region"
names(yield_subset)[names(yield_subset) == "yield_df.End.Date"] <- "End.Date"
names(yield_subset)[names(yield_subset) == "yield_df.Value"] <- "Value"

# Remove null
yield_subset <- yield_subset [!yield_subset $Value == "null", ]

# Convert string Value to numeric
yield_subset$Value <- as.numeric(yield_subset$Value)

# Extract year data
yield_subset$End.Date <- ymd(yield_subset$End.Date)
yield_subset$year <- year(yield_subset$End.Date)

# Line plot
plot((yield_subset$Value[yield_subset$Region == "Canada"]), xaxt="n", type="o")