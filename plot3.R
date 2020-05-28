if (!file.exists("./data")){
    dir.create("./data")
}

if (!file.exists("./data/household_power_consumption.txt")){
    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileURL, "./data/household_power_consumption.zip", method = "curl")
    unzip("./data/household_power_consumption.zip", exdir = "./data/")
}

#con <- file("./data/household_power_consumption.txt", "r")
#close(con)
data <- read.table("./data/household_power_consumption.txt", header=TRUE, sep=";", na.strings ="?")

data$Date <- as.Date(data$Date, format= "%d/%m/%Y")
data$DateTime <- paste(data$Date, data$Time)
data$DateTime <- strptime(data$DateTime, format= "%Y-%m-%d %H:%M:%S")

## The actual data to use
February <- subset(data, data$Date == "2007-02-01" | data$Date == "2007-02-02")

png(filename= "plot3.png", 
    width = 480,
    height = 480,
    units = "px")
with(February, plot(DateTime, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")) 
with(February, {
    points(DateTime, Sub_metering_1, type = "l", col = "black")
    points(DateTime, Sub_metering_2, type = "l", col = "red")
    points(DateTime, Sub_metering_3, type = "l", col = "blue")
})
dev.off()