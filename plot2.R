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

# create plot2 PNG file
png(file = "plot2.png")

# create plot2

plot(feb1and2$DateTime, feb1and2$Global_active_power, xlab = "", 
     ylab = "Global Active Power (kilowatts)", type = "l")

dev.off()
