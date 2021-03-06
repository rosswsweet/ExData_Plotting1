# This code was written for the Week 1 Programming Assignment in the Exploratory Data Analysis
# course on Coursera.
# The code imports a data set containing measurements of electricity use in a house ever minute
# over a period of years. The data is filtered to two days and four plots in a grid are produced
# and printed to a png file:
#   Top left plot - line graph of household global minute-averaged active power in kilowatts over time
#   Top right plot - line graph of minute-averaged voltage over time
#   Bottom left plot - line graphs of energy sub-metering in watt-hour of active energy over time
#       Sub_metering_1 - corresponds to the kitchen, containing mainly a dishwasher, an oven 
#                        and a microwave (hot plates are not electric but gas powered)
#       Sub_metering_2 - corresponds to the laundry room, containing a washing-machine, 
#                        a tumble-drier, a refrigerator and a light
#       Sub_metering_3 - corresponds to an electric water-heater and an air-conditioner
#   Bottom right plot - line graph of household global minute-averaged reactive power in kilowatts over time
# Code developed by Ross Sweet.

library(dplyr)  # Needed for filter, mutate, and the pipe operator
library(lubridate)  # Needed to convert character strings into POSIXct with dmy_hms

# The full data set is read in from a text file with entries separated by a semicolon. Entries of "?"
# are coerced to NAs and the column classes are specified. The data is filtered for the desired days
# and the full data set removed from the environment.
fullData <- read.table("household_power_consumption.txt", header = TRUE, sep = ";",
                       stringsAsFactors = FALSE, na.strings = "?",
                       colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
filtData <- filter(fullData, Date == "1/2/2007" | Date == "2/2/2007")
rm(fullData)

# A new column DateTime is made by pasting the Date and Time variables, then converted to POSIXct.
filtData <- filtData %>%
  mutate(DateTime = paste(Date, Time, sep = " ")) %>%
  mutate(DateTime = dmy_hms(.$DateTime))

# The graphs are produced and printed to the file plot4.png
png(file = "plot4.png", width = 480, height = 480)

par(mfrow = c(2,2))
# Top left plot
plot(filtData$DateTime, filtData$Global_active_power, type = "l", 
              xlab = "", ylab = "Global Active Power")
# Top right plot
plot(filtData$DateTime, filtData$Voltage, type = "l", 
              xlab = "datetime", ylab = "Voltage")
# Bottom left plot
plot(filtData$DateTime, filtData$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
  lines(filtData$DateTime, filtData$Sub_metering_1, type = "l")
  lines(filtData$DateTime, filtData$Sub_metering_2, type = "l", col = "red")
  lines(filtData$DateTime, filtData$Sub_metering_3, type = "l", col = "blue")
  legend("topright", lty = 1 , col = c("black", "red", "blue"), bty = "n",
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# Bottom right plot
plot(filtData$DateTime, filtData$Global_reactive_power, type = "l", 
              xlab = "datetime", ylab = "Global_reactive_power")
 
 dev.off()
 
 
 