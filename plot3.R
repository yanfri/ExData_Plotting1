###################################
# Exploratory data analysis
# Course project 1 - Plot 3
###################################

setwd("./ExploratoryDataAnalysis/Exercises/CourseProject1/ExData_Plotting1")

# creates a directory 'data' if not already existing
if(!file.exists("data")){
     dir.create("data")
}

# download dataset from given url
url_elecpowcons = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(url_elecpowcons, destfile = "./data/elpowcons.zip")
downloaddate <- date()

# memory usage:
2075259*9*8/2^20 # = 142.5 MB

#reads the txt file from the zip file into data frame 'd'
d <- read.table(unzip("./data/elpowcons.zip"), header = T, sep = ";", na.strings = "?")

#selects only entries of February 1 and 2, 2007
d <- d[(d$Date == "1/2/2007" | d$Date == "2/2/2007"),]

# converts 'Date' and 'Time' to time data
d$Time <- strptime(paste(d$Date, d$Time, sep = " "), "%e/%m/%Y %H:%M:%S")
d$Date <- as.Date(d$Date, "%e/%m/%Y")

# sets system to English settings 
Sys.setlocale("LC_TIME", "English")

# generates the plot in a png file 
png("plot3.png", width = 480, height = 480, units = "px")

plot(d$Time, d$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l", col = "black")
lines(d$Time, d$Sub_metering_2, col = "red")
lines(d$Time, d$Sub_metering_3, col = "blue")
legend("topright", legend = names(d[, 7:9]), lty = rep(1, 3), col = c("black", "red", "blue"))

dev.off()

