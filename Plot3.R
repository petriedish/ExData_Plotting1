##This Script will download the dataset and create Plot3.png to satisfy part2 of the Week 1 Course Project

#loading the dependencies
library(dplyr)

#placing the dataset URL in an object
url1 <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
	#downloading the dataset in zip format
	download.file(url1, destfile = "household_power_consumption.zip", mode = "wb", method = "libcurl")
	#unzip the dataset into a text file to be read by read.table
	unzip("household_power_consumption.zip")

#read the data into an R object
df1 <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")
	#creating the preferred data frame for dplyr (probably unnecessary)
	df1 <- tbl_df(df1)
	#formatting date 
	df1$Date <- as.Date(df1$Date, format = "%d/%m/%Y")
	#filtering data to contain only the 2 dates needed
	df1 <- filter(df1, Date == "2007-02-01" | Date == "2007-02-02")
	#pasting dates and times together into a single complete datetime
	df1$Date <- as.POSIXct(paste(df1$Date, df1$Time), format="%Y-%m-%d %H:%M:%S")

#Creating the png file
png(file="Plot3.png")
	#making an empty plot with the correct axis size based on largest y-value
	plot(df1$Date, sample(1:38, length(df1$Date), replace=TRUE),type = "n", ylab = "Energy sub metering", xlab = "")
	#adding in each plot using lines to connect the points
	lines(df1$Date, df1$Sub_metering_1)
	lines(df1$Date, df1$Sub_metering_2, col="red")
	lines(df1$Date, df1$Sub_metering_3, col="blue")
	#adding the legend using lty to specify the leading line for each legend entry
	legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
	dev.off()