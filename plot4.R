library(sqldf)
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(url, temp, mode="wb")
myDir <- unzip(temp)
myDataF<- read.csv.sql(myDir, sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007'", header = TRUE, sep = ";")

rawTime <- paste(myDataF$Date, myDataF$Time) #Put the dates and times together
#c <- as.Date(rawTime, format = %d/%m/%Y) Gives only date format DISREGARD IN FINAL CODE
formatTime <- strptime(rawTime, format = "%d/%m/%Y %H:%M:%S") #Correctly format time
unlist(formatTime) #convert formatTime variable from a list to a vector
myDataF <- cbind(formatTime, myDataF) #Add formatted time to the dataframe
myDataF <- myDataF[,-(2:3)] #Delete the redundant Date and Time columns.
#formatTime will be the column variable for the added column, so change
#the variable name to sth more appropriate, e.g Date.Time----see next line.
png(file = "ExData_Plotting1/plot4.png")
colnames(myDataF)[1] <- "Date.Time"
par(mfrow = c(2, 2))
plot(myDataF$Date.Time, myDataF$Global_active_power, type = "n", col= "black", xlab = "", ylab = "Global Active Power (kilowatts)")
lines(myDataF$Date.Time, myDataF$Global_active_power)
plot(myDataF$Date.Time, myDataF$Voltage, type = "n", col= "black", xlab = "datetime", ylab = "Voltage")
lines(myDataF$Date.Time, myDataF$Voltage)
plot(myDataF$Date.Time, myDataF$Sub_metering_1, type = "n", col= "black", xlab = "", ylab = "Energy sub metering")
lines(myDataF$Date.Time, myDataF$Sub_metering_1, col = "black")
lines(myDataF$Date.Time, myDataF$Sub_metering_2, col = "red")
lines(myDataF$Date.Time, myDataF$Sub_metering_3, col ="blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1, 1), col = c("black", "red", "blue"), bty ="n")
plot(myDataF$Date.Time, myDataF$Global_reactive_power, type = "n", col= "black", xlab = "datetime", ylab = "Global_reactive_power")
lines(myDataF$Date.Time, myDataF$Global_reactive_power)
dev.off()


