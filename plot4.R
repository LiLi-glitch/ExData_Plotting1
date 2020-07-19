#Download data and put in dataframe 
Dataset <- download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "HPC.zip")
unzip(zipfile = "./HPC.zip", exdir = ".")

#load text file in dataframe, skip the first row because that contains the columns and seperate based on ; 
HPC <- read.table("household_power_consumption.txt", skip = 1, sep = ";")

#name the columns again
names(HPC)<- c("Date", "Time", "Global_active_power", "Global_reactive_power", 
               "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

#subset data between 2007-02-01 and 2007-02-02
HPC$Date <- as.Date(HPC$Date, format = "%d/%m/%Y")
HPC1 <- subset(HPC, HPC$Date == "2007/2/1" | HPC$Date == "2007/2/2")

#combine date and time
DateTime <- paste(HPC1$Date, HPC1$Time)
DateTime <- strptime(DateTime, format = "%Y-%m-%d %H:%M:%S")
HPC1$DateTime <- DateTime

#plot more plots on 1 plot
par(mfrow = c(2,2))

#########plot1
#plot1 is a histogram, frequency of Global_active_power. 
plot(HPC1$DateTime, as.numeric(as.character(HPC1$Voltage)), type = "l", 
     xlab = "datetime", ylab = "Voltage")

########plot2
#plot2 is a line plot (show with type = "l") 
plot(HPC1$DateTime, as.numeric(as.character(HPC1$Global_active_power)), type = "l", 
     xlab = "", ylab = "Global Active Power(kilowatts)")

########Plot 3
#plot3 is a combination of plots that can be added by subsets. 
plot(HPC1$DateTime, as.numeric(as.character(HPC1$Sub_metering_1)), type = "n", 
     xlab = "", ylab = "Energy sub-metering")

with(HPC1, lines(DateTime, as.numeric(as.character(HPC1$Sub_metering_1))))
with(HPC1, lines(DateTime, as.numeric(as.character(HPC1$Sub_metering_2)), col = "Red"))
with(HPC1, lines(DateTime, as.numeric(as.character(HPC1$Sub_metering_3)), col = "Blue"))

#add legend
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

########Plot4
plot(HPC1$DateTime, as.numeric(as.character(HPC1$Global_reactive_power)), type = "l", 
     xlab = "datetime", ylab = "Global_reactive_power")

#save paired plot4
png("plot4.png", width = 480, height = 480)

#plot more plots on 1 plot
par(mfrow = c(2,2))

#########plot1
#plot1 is a histogram, frequency of Global_active_power. 
plot(HPC1$DateTime, as.numeric(as.character(HPC1$Voltage)), type = "l", 
     xlab = "datetime", ylab = "Voltage")

########plot2
#plot2 is a line plot (show with type = "l") 
plot(HPC1$DateTime, as.numeric(as.character(HPC1$Global_active_power)), type = "l", 
     xlab = "", ylab = "Global Active Power(kilowatts)")

########Plot 3
#plot3 is a combination of plots that can be added by subsets. 
plot(HPC1$DateTime, as.numeric(as.character(HPC1$Sub_metering_1)), type = "n", 
     xlab = "", ylab = "Energy sub-metering")

with(HPC1, lines(DateTime, as.numeric(as.character(HPC1$Sub_metering_1))))
with(HPC1, lines(DateTime, as.numeric(as.character(HPC1$Sub_metering_2)), col = "Red"))
with(HPC1, lines(DateTime, as.numeric(as.character(HPC1$Sub_metering_3)), col = "Blue"))

#add legend
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

########Plot4
plot(HPC1$DateTime, as.numeric(as.character(HPC1$Global_reactive_power)), type = "l", 
     xlab = "datetime", ylab = "Global_reactive_power")
dev.off()