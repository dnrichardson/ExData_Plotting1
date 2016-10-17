## R script to generate plots for assignment 1 of Exploratory Data Analysis 
## October 16, 2016
## Dale Richardson

## We will only be using data from the dates 2007-02-01 and 2007-02-02. 
## In the data file, the dates are in the format, Day/Month/Year. 
## I will make life easy and grep only the lines corresponding to 1/2/2007 and 2/02/2007

## Here's the grep command line on bash: grep -w '1/2/2007\|2/2/2007' household_power_consumption.txt
## Let's try it in R, should be 2880 lines

myData <- read.table(pipe("grep -w '1/2/2007\\|2/2/2007' household_power_consumption.txt"), header=FALSE, 
                     sep = ";", na.strings = "?", stringsAsFactors = FALSE,
                     colClasses = c("character", "character", rep("numeric", 7)),
                     col.names = c("Date", "Time", "Global_active_power",
                                   "Global_reactive_power", "Voltage", 
                                   "Global_intensity", "Sub_metering_1", 
                                   "Sub_metering_2", "Sub_metering_3"))

## apply the strptime function to create new variable for plotting

myData$myDate = strptime(paste(myData$Date, myData$Time, sep =" "), "%d/%m/%Y %H:%M:%S") 

## Create the fourth plot, a 4-panel plot of Global_active_power vs myDate, Voltage vs myDate (xlab = datetime),
## energy sub metering vs  and Global_reactive_power vs myDate (xlab = datetime, ylab = Global_reactive_power)

png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2), bg = NA)
plot(myData$myDate, myData$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)",
     xlab = "")

plot(myData$myDate, myData$Voltage, type = "l", ylab = "Voltage",
     xlab = "datetime")

plot(myData$myDate, myData$Sub_metering_1, type = "l", ylab = "Energy sub metering",
     xlab = "")
lines(myData$myDate, myData$Sub_metering_2, col = "red")
lines(myData$myDate, myData$Sub_metering_3, col = "blue")
legend(x = "topright", lty=c(1,1), c("Sub_metering 1", "Sub_metering 2", "Sub_metering 3"),
       col = c("black", "red", "blue"))

plot(myData$myDate, myData$Global_reactive_power, type = "l", ylab = "Global_reactive_power",
     xlab = "datetime")
dev.off()
