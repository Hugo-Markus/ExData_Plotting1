# Load dplyr
library(dplyr)

# Download dateset 
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "./dataset.zip")
unzip(zipfile = "./dataset.zip", exdir = "./")

# Road text file as a table
data <- read.table("./household_power_consumption.txt", sep=";", header = TRUE)

# Convert columns Global_active_power through Sub_metering_3 to numeric
data[, 3:8] <- lapply(data[, 3:8], as.numeric)

# Convert dates to POSIXct
data <- mutate(data ,DateTime = as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S"))

# Select only the first two days of February 2007
two_days <- subset(data, Date == "1/2/2007" | Date == "2/2/2007" )

# Create png image of plot
png("plot2.png", width=480, height=480)

# Make plot
plot(two_days$DateTime, two_days$Global_active_power, xlab = "",
     ylab = "Global Active Power (kilowatts)", type="l")

dev.off()
