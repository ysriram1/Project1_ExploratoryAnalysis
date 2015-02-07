#### Plot3.R
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
rm(data)

## Creating a new data and time column
install.packages("lubridate")
library(lubridate)
data_needed$Day <- format(data_needed$Date, "%A")
data_needed$date_time <- ymd_hms(paste(data_needed$Date, data_needed$Time, sep=" "))

### Plot 3
par(mfrow = c(1,1))
with(data_needed, plot(date_time, Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = ""))
with(data_needed, lines(date_time, Sub_metering_1, col = "black"))
with(data_needed, points(date_time, Sub_metering_2, type = "n"))
with(data_needed, lines(date_time, Sub_metering_2, col = "red"))
with(data_needed, points(date_time, Sub_metering_3, type = "n"))
with(data_needed, lines(date_time, Sub_metering_3, col = "blue"))  
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1  ","Sub_metering_2  ","Sub_metering_3  "))
dev.copy(png, file="plot3.png")
dev.off()