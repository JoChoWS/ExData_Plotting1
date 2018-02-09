library(dplyr)
library(data.table)
library(lubridate)

# read in the data, replace ? values with NA
household <- read.table(".//household_power_consumption.txt", sep = ";", header = TRUE, na.strings = c("?","NA"))

# convert date column to R friendly format
household$Date <- strptime(household$Date, "%d/%m/%Y")
household$Date <- as.Date(household$Date)

# narrow household data to February 1-2, 2007
feb1 <- household[grep(("2007-02-01"),household$Date),]
feb2 <- household[grep(("2007-02-02"),household$Date),]
feb1and2 <- rbind(feb1, feb2)

DateTime <- paste(feb1and2$Date, feb1and2$Time)
feb1and2$DateTime <- as.POSIXct(DateTime)

# create plot4 PNG file
png(file = "plot4.png")

# set multiple plot parameters
par(mfrow = c(2,2), mar = c(4,4,2,1))

#create plot4
with(feb1and2, {
  plot(DateTime, Global_active_power, xlab = "", ylab = "Global Active Power", type = "l")
  
  plot(DateTime, Voltage, xlab = "datetime", ylab = "", type = "l")
  
  plot(DateTime, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l")
  lines(feb1and2$DateTime, feb1and2$Sub_metering_2, type = "l", col = "red")
  lines(feb1and2$DateTime, feb1and2$Sub_metering_3, type = "l", col = "blue")
  legend("topright", lty = 1, col = 1:3, bty = "n", 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  plot(DateTime, Global_reactive_power, xlab = "datetime", type = "l")
})               


dev.off()
