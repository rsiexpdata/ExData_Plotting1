#Project1, Plot4 - Exploratory Data Analysis
#Author: RSI
#Date: 9/13/2015

## Reading in Data  - takes some time since data file is very large ##

filename <- "./household_power_consumption.txt"

#read a small sample of large data file to get column types
initial <- read.table(filename, header = TRUE, nrows = 100)
classes = sapply(initial, class)

#now read the complete large data file
power <- read.table(file = filename, colClasses = classes, header = TRUE, sep = ";", stringsAsFactors=FALSE, na.strings = "?")

#extract data only for 2 days in February 2007 (for Feb 1 and 2 Date is in dd/mm/yyyy format)
subSetPower <- power[power$Date %in% c("1/2/2007","2/2/2007") ,]

#get global active power data only
gap <- as.numeric(subSetPower$Global_active_power)

#get each of the three sub-metering data
submet1 <- as.numeric(subSetPower$Sub_metering_1)
submet2 <- as.numeric(subSetPower$Sub_metering_2)
submet3 <- as.numeric(subSetPower$Sub_metering_3)

#get Voltage data
volt <- as.numeric(subSetPower$Voltage)

#get Global_reactive_power data
grp <- as.numeric(subSetPower$Global_reactive_power)

#get date/time using strptime() function class
x <- paste(subSetPower$Date, subSetPower$Time)
datetime <- strptime(x, format = "%d/%m/%Y %H:%M:%S")

## Plotting data ##
#This does not display on screen, but saves directly to the plot1.png file

png(file = "plot4.png", width = 480, height = 480, bg = "transparent")

#use mfcol creates the four plots in column-order below
par(mfcol = c(2, 2))

#create top left plot
plot(datetime, gap, type = "l", xlab = "", ylab="Global Active Power")

#create bottom left plot
#create a blank plot with axes limits based on submet1 data
plot(datetime, submet1, type = "n", xlab = "", ylab="Energy sub metering")
#Now plot the data for each of the sub meterings
lines(datetime, submet1)
lines(datetime, submet2, col = "red")
lines(datetime, submet3, col = "blue")
#add legend to plot
legend("topright", lwd = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#create top right plot
plot(datetime, volt, type = "l", ylab="Voltage")

#create bottom right plot
plot(datetime, grp, type = "l", ylab = "Global_reactive_power")

#Alternate method
#First create the plots to show on screen device and then save as a png file of width and height of 480 pixels
#dev.copy(png, file = "plot4.png", width = 480, height = 480, bg = "transparent")

dev.off()
