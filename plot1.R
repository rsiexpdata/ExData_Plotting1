#Project1, Plot1 - Exploratory Data Analysis
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

## Plotting data ##
#This does not display on screen, but saves directly to a png file

png(file = "plot1.png", width = 480, height = 480, bg = "transparent")
hist(gap, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")


#Alternate method
#This shows hist on screen device and then is saved as a png file of width and height of 480 pixels
#hist(gap, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
#dev.copy(png, file = "plot1.png", width = 480, height = 480, bg = "transparent")

dev.off()


