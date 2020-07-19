library(tidyr)

Sys.setlocale("LC_ALL", "English")

#Download data and put in dataframe 
Dataset <- download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "HPC.zip")
unzip(zipfile = "./HPC.zip", exdir = ".")

#load text file in dataframe, skip the first row because that contains the columns and seperate based on ; 
HPC <- read.table("household_power_consumption.txt", skip = 1, sep = ";")

#name the columns again
names(HPC)<- c("Date", "Time", "Global_active_power", "Global_reactive_power", 
               "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

#Make Date a Date
HPC$Date <- as.Date(HPC$Date, format = "%d/%m/%Y")

#subset data between 2007-02-01 and 2007-02-02
HPC1 <- subset(HPC, HPC$Date == "2007/2/1" | HPC$Date == "2007/2/2")

#Combine Date and Time
DateTime <- paste(HPC1$Date, HPC1$Time)
DateTime <- strptime(DateTime, format = "%Y-%m-%d %H:%M:%S")
HPC1$DateTime <- DateTime

#save plot2 as png
png("plot2.png", width = 480, height = 480)

plot(HPC1$DateTime, as.numeric(as.character(HPC1$Global_active_power)), type = "l", 
     xlab = "", ylab = "Global Active Power(kilowatts)")

dev.off()
