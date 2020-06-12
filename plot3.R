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


## Plot3
png(filename = "plot3.png", width = 480, height = 480, units = "px")
plot(data$datetime, data$Sub_metering_1, type = "n", ann = FALSE)
title(xlab = "", ylab = "Energy sub metering")
lines(data$datetime, data$Sub_metering_1)
lines(data$datetime, data$Sub_metering_2, col = "red")
lines(data$datetime, data$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()



