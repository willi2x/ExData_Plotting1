#Load Packages
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

#Create Plot 2
#convert dates to correct class and format
hpc$Date <- as.Date(hpc$Date, format = "%d/%m/%Y")
#add Date and Time together in new variable called DateTime
DateTime <- paste(as.Date(hpc$Date), hpc$Time)
#convert to correct Date\Time class 
hpc$DateTime <- as.POSIXct(DateTime)

#Make Plot and add label to y axis
plot(hpc$Global_active_power ~ hpc$DateTime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

# Save as PNG
dev.copy(png,"plot2.png")
dev.off()