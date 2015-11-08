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
colnames(myDataF)[1] <- "Date.Time"
hist(myDataF$Global_active_power, col= "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.copy(png, file = "ExData_Plotting1/plot1.png")
dev.off()

