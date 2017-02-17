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

#set the window size
win.graph(200,200)
# Set number of columns and rows for multiple plots
par(mfcol=c(2,2))

# Create First plot
#convert dates to correct class and format
hpc$Date <- as.Date(hpc$Date, format = "%d/%m/%Y")
#add Date and Time together in new variable called DateTime
DateTime <- paste(as.Date(hpc$Date), hpc$Time)
#convert to correct Date\Time class 
hpc$DateTime <- as.POSIXct(DateTime)

#Make Plot and add label to y axis
plot(hpc$Global_active_power ~ hpc$DateTime, type = "l", ylab = "Global Active Power", xlab = "")

#Create second plot
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

#Create Third plot
with(hpc, plot(Voltage ~ DateTime, type = "l",ylab = "Voltage", xlab = "datetime"))
     
#Create fourth plot
with(hpc, plot(Global_reactive_power ~ DateTime, type = "l",ylab = "Global_reactive_power", xlab = "datetime"))

# Save as PNG
dev.copy(png,"plot4.png")
dev.off()
