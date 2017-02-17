library(downloader)
#Download file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download(fileUrl, dest="dataset.zip", mode="wb") 
#Unzip file
unzip(zipfile="./dataset.zip",exdir="./data")
#set working directory
setwd("C:/wd/EDA/data")

#Clean up table, separate values and label
hpc <- read.table("./household_power_consumption.txt", skip = 66637, nrow = 2880, sep = ";")
n <- sapply(read.table("household_power_consumption.txt", nrow = 1, sep = ";"), as.character)
names(hpc) <- n

#Create Plot 3
with(hpc, {
 #First line Sub_metering 1
   plot(Sub_metering_1 ~ DateTime, type = "l", 
       ylab = "Energy sub metering", xlab = "")
  #Second line Sub_metering 2
  lines(Sub_metering_2 ~ DateTime, col = 'Red')
  #Third line Sub_metering 3
  lines(Sub_metering_3 ~ DateTime, col = 'Blue')
})
#Create legend in top right corner
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Save as PNG
dev.copy(png,"plot3.png")
dev.off()