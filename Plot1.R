# Load dplyr
library(dplyr)

# Download dateset 
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "./dataset.zip")
unzip(zipfile = "./dataset.zip", exdir = "./")

# Road text file as a table
data <- read.table("./household_power_consumption.txt", sep=";", header = TRUE)

# Convert Date column to Date type
data$Date <-as.Date(data$Date,"%d/%m/%Y")

# Convert columns Global_active_power through Sub_metering_3 to numeric
data[, 3:8] <- lapply(data[, 3:8], as.numeric)

# Select only the first two days of February 2007
two_days <- subset(data, Date == "2007-02-01" | Date == "2007-02-02" )

# Create png image of plot
png("plot1.png", width=480, height=480)

# Make histogram
hist(two_days$Global_active_power, col="Red", xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")

dev.off()
