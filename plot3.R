## Read Data
##==========

# Set read file
file <- unz("exdata-data-household_power_consumption.zip", "household_power_consumption.txt")
# Get column names from header row
names <- scan(file, what="text", sep=";", quiet=T, nlines=1)
# Read - only the required lines
data <-read.table(file, header=F, sep=";", na.strings="?", skip=66637, nrows=2880,
                  col.names=names, colClasses=c("character", "character",rep("numeric", 7)))
# Combine Date & Time to same column
data$Date <- paste(data$Date, data$Time, sep=" ")
data$Time <- NULL
# Change to data/time format
data$Date <- as.POSIXct(data$Date, format = "%d/%m/%Y %T")
names(data)[1] <- "datetime"


## Make Plot (3)
##==============

#Set up save file
png(file="plot3.png", width = 480, height = 480, units = "px")
# Plot
with(data, {
    plot(datetime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
    lines(datetime, Sub_metering_2, col="Red")
    lines(datetime, Sub_metering_3, col="Blue")
})
# Add Legend
legend("topright", col=c("Black","Red","Blue"), lty=1,
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# Save to PNG - OLD
# dev.copy(png, file="plot3.png", width = 480, height = 480, units = "px")
# Close PNG
dev.off()
