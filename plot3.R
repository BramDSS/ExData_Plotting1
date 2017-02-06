################################################################################
##
## Assumed is the following:
## * the data has been downloaded & unzipped
## * the resulting textfile is named "household_power_consumption.txt"
## * this textfile is in the working directory
##
## The script will create a png-plot called "plot3.png" and this plot
## will be saved to the working directory.
##
################################################################################

## Load data into R
hopoco <- read.table("household_power_consumption.txt",
                     sep = ";", header = TRUE,
                     na.strings = "?", stringsAsFactors = FALSE)
# Since only data from 2007-02-01 and 2007-02-02 will be used: select only these data
hopoco <- subset(hopoco, Date %in% c("1/2/2007", "2/2/2007"))
# Convert date and time to correct classes
hopoco$Time <- strptime(paste(hopoco$Date,hopoco$Time), format = "%d/%m/%Y %H:%M:%S")
hopoco$Date <- as.Date(hopoco$Date, format="%d/%m/%Y")

## To get Enlish abbreviations for weekdays:
Sys.setlocale("LC_TIME", "English")

## make plot
par(mfrow = c(1,1))
with(hopoco, plot(Time, Sub_metering_1, type = "n", xlab ="", ylab = "Energy sub metering"))
with(hopoco,lines(hopoco$Time, hopoco$Sub_metering_1, col = "black"))
with(hopoco,lines(hopoco$Time, hopoco$Sub_metering_2, col = "red"))
with(hopoco,lines(hopoco$Time, hopoco$Sub_metering_3, col = "blue"))
legend("topright",
       lty = 1,
       col = c("black", "blue", "red"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Write png file
dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()
