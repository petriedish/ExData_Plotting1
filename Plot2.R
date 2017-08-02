##This Script will download the dataset and create Plot2.png to satisfy part2 of the Week 1 Course Project

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
	df1 <- tbl_df(df1)
	df1$Date <- as.Date(df1$Date, format = "%d/%m/%Y")
	df1 <- filter(df1, Date == "2007-02-01" | Date == "2007-02-02")
	df1$Date <- as.POSIXct(paste(df1$Date, df1$Time), format="%Y-%m-%d %H:%M:%S")

#Creating the png file
png(file="Plot2.png")
	plot(df1$Date, df1$Global_active_power, type = "n", ylab = "Global Active Power (kilowatts)", xlab = "")
	lines(df1$Date, df1$Global_active_power)
	dev.off()