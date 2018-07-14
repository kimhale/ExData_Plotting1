# Set working directory
setwd("/Users/kimberlyhale/Documents/Coursera/DataScienceCert/C4_EDA/ExData_Plotting1")

# Load packages
library(data.table)

# Download file if data doesn't exist
if (!file.exists("data/household_power_consumption.txt")){
  dir.create("data")
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, destfile = "data/HouseholdPower.zip", method = "curl")
  #Unzip file
  zipF<- "data/HouseholdPower.zip"
  outDir<-"data"
  unzip(zipF,exdir=outDir)
}

# Read data into datatable
dt <- fread("data/household_power_consumption.txt", na.strings = "?")

# Check that data is as expected
head(dt)
summary(dt)

# Turn Date into Date class and filter to just Feb 01-02 2007
dt$Date <- as.Date(dt$Date, format = "%d/%m/%Y")
dt <- dt[(dt$Date >= as.Date("2007-02-01") & dt$Date <= as.Date("2007-02-02")), ]

# Turn Date/Time into Date/Time instead of character
dt$DateTime <- paste(dt$Date, dt$Time, sep = " ")
dt$DateTime <- as.POSIXct(dt$DateTime, format = "%Y-%m-%d %H:%M:%S")

# Check that data is as expected
dt$DateTime[2] - dt$DateTime[1]
head(dt$DateTime)

# Plot Global Active Power over time, change title, y-axis title
# Save it to a PNG file, width of 480 pixels and height of 480 pixels, named plot2.png
png(filename = 'plot2.png', width = 480, height = 480)
plot(x = dt$DateTime, y = dt$Global_active_power, type = "n", main = NULL, 
     ylab = "Global Active Power (kilowatts)", xlab = "")
lines(x = dt$DateTime, y = dt$Global_active_power)
dev.off()
