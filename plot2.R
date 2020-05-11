# This code was written for the Week 1 Programming Assignment in the Exploratory Data Analysis
# course on Coursera.
# The code imports a data set containing measurements of electricity use in a house ever minute
# over a period of years. The data is filtered to two days and a line graph of household global 
# minute-averaged active power in kilowatts over time is printed to a png file.
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

# The line graph is produced and printed to the file plot2.png
png(file = "plot2.png", width = 480, height = 480)

plot(filtData$DateTime, filtData$Global_active_power, type = "l", 
      xlab = "", ylab = "Global Active Power (kilowatts)")

dev.off()
 
 
 