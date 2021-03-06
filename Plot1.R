library(dplyr)
url1 <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url1, destfile = "household_power_consumption.zip", mode = "wb", method = "libcurl")
unzip("household_power_consumption.zip")
df1 <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")
df1$Date <- as.Date(df1$Date, format = "%d/%m/%Y")
df1 <- filter(df1, Date == "2007-02-01" | Date == "2007-02-02")
png(file="Plot1.png")
hist(df1$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.off()