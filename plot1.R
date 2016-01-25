## Read Data
##==========

# Get column names from header row
names <- scan("household_power_consumption.txt", what="text", sep=";", quiet=T, nlines=1)
# Read - only the required lines
data <- read.table("household_power_consumption.txt", header=F, sep=";", na.strings="?", skip=66637, nrows=2880, colClasses=c("character", "character", rep("numeric", 7)), col.names=names)
# Combine Date & Time to same column
data$Date <- paste(data$Date, data$Time, sep=" ")
data$Time <- NULL
# Change to data/time format
data$Date <- as.POSIXct(data$Date, format = "%d/%m/%Y %T")
names(data)[1] <- "datetime"


## Make Plot (1)
##==============

#Set up save file
png(file="plot1.png", width = 480, height = 480, units = "px")
# Plot
hist(data$Global_active_power, xlab="Global Active Power (kilowatts)", col="Red", main="Global Active Power")
# Save to PNG - OLD!
# dev.copy(png, file="plot1.png", width = 480, height = 480, units = "px")
# Close PNG
dev.off()
