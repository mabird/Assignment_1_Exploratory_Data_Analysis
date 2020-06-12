rm(list = ls())

## read in the first 50 rows to check the column classes
initial <- read.table("household_power_consumption.txt", sep = ";", nrows = 50,
                       stringsAsFactors = FALSE, colClasses = "character", header = TRUE)
sapply(initial, class)

## read in data and subset on the two given dates
data_all <- read.table("household_power_consumption.txt", sep = ";",
                       stringsAsFactors = FALSE, colClasses = "character", header = TRUE)

data <- data_all[data_all$Date == "1/2/2007" | data_all$Date == "2/2/2007", ]

## create the datetime column from Date and Time and change to date-time object
data$datetime <- paste(data$Date, data$Time, sep = " ")
data$datetime <- strptime(data$datetime, "%d/%m/%Y %H:%M:%S" )

## change the value columns to numeric and check the column classes again
data[3:9] <- apply(data[3:9], 2, as.numeric)
sapply(data, class)


## Plot2
png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(data$datetime, data$Global_active_power, type = "n", ann = FALSE)
lines(data$datetime, data$Global_active_power)
title(xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()


