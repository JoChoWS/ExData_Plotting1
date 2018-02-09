library(dplyr)
library(data.table)

# read in the data, replace ? values with NA
household <- read.table(".//household_power_consumption.txt", sep = ";", header = TRUE, na.strings = c("?","NA"))

# convert date column to R friendly format
household$Date <- strptime(household$Date, "%d/%m/%Y")
household$Date <- as.Date(household$Date)

# narrow household data to February 1-2, 2007
feb1 <- household[grep(("2007-02-01"),household$Date),]
feb2 <- household[grep(("2007-02-02"),household$Date),]
feb1and2 <- rbind(feb1, feb2)

# create plot1 PNG file
png(file = "plot1.png")

# create plot1

hist(feb1and2$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

dev.off()
