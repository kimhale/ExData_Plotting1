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

# Plot 4 plots in a grid
# Save it to a PNG file, width of 480 pixels and height of 480 pixels, named plot4.png
png(filename = 'plot4.png', width = 480, height = 480)
par(mfrow = c(2, 2))

# Plot Global Active Power over time
plot(x = dt$DateTime, y = dt$Global_active_power, type = "n", main = NULL, 
     ylab = "Global Active Power (kilowatts)", xlab = "")
lines(x = dt$DateTime, y = dt$Global_active_power)

# Plot Voltage over time
plot(x = dt$DateTime, y = dt$Voltage, type = "n", main = NULL, ylab = "Voltage", 
     xlab = "datetime")
lines(x = dt$DateTime, y = dt$Voltage)

# Plot Sub-metering over time
plot(x = dt$DateTime, y = dt$Sub_metering_1, type = "n", main = NULL, 
     ylab = "Energy sub metering", xlab = "")
lines(x = dt$DateTime, y = dt$Sub_metering_1, col = "black")
lines(x = dt$DateTime, y = dt$Sub_metering_2, col = "red")
lines(x = dt$DateTime, y = dt$Sub_metering_3, col = "blue")
legend(x = "topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lty=1:2, cex=0.8)

# Plot Global Reactive Power over time
plot(x = dt$DateTime, y = dt$Global_reactive_power, type = "n", main = NULL,
     ylab = "Global_reactive_power", xlab = "datetime")
lines(x = dt$DateTime, y = dt$Global_reactive_power)

dev.off()
