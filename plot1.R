#### Plot1.R
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

### Plot 1
par(mar = c(5.1,6, 4.1, 2.1), mfrow = c(1,1))
plot1 <- hist(data_needed[,3], main = "Global Active Power", breaks = 11, col = "red", ylim=c(0,1200), xlab = "Global Active Power (kilowatts)")
dev.copy(png, file="plot1.png")
dev.off()