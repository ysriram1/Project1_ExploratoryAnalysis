#### Plot4.R
### Getting the Data
## Reading data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "./data5.zip")
files <- unzip("data5.zip")
data <- read.table(files[1], header= TRUE, sep = ";")

## Assigning right date class to the date column
data$Date <- as.Date(as.character(data$Date),"%d/%m/%Y")

## Subsetting the necessary data
data_needed <- data[(data$Date == as.Date("1/2/2007", "%d/%m/%Y") | data$Date== as.Date("2/2/2007", "%d/%m/%Y") ),]
row.names(data_needed) = NULL
## Converting remaining columns to numeric
for(x in 3:9){
  data_needed[,x] <- as.numeric(as.character(data_needed[,x]))
}

## Plot 4
par(mfrow = c(2,2))
with(data_needed, {
  plot(date_time, Global_active_power, ylab= "Global Active Power", xlab = "", type = "n")
  lines(date_time, Global_active_power)
  plot(date_time, Voltage, ylab="Voltage", xlab="datetime", type = "n")
  lines(date_time, Voltage)
  plot(date_time, Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = "")
  lines(date_time, Sub_metering_1, col = "black")
  points(date_time, Sub_metering_2, type = "n")
  lines(date_time, Sub_metering_2, col = "red")
  points(date_time, Sub_metering_3, type = "n")
  lines(date_time, Sub_metering_3, col = "blue")
  legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty = "n")
  plot(date_time, Global_reactive_power, ylab= "Global_reactive_power", xlab = "datetime", type = "n")
  lines(date_time, Global_reactive_power)
})
dev.copy(png, file="plot4.png")
dev.off()