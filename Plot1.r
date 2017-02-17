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

#Create Plot 1 Histogram
hist(hpc$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power")
# Save as PNG
dev.copy(png,"plot1.png")
dev.off()
