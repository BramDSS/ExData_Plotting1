################################################################################
##
## Assumed is the following:
## * the data has been downloaded & unzipped
## * the resulting textfile is named "household_power_consumption.txt"
## * this textfile is in the working directory
##
## The script will create a png-plot called "plot1.png" and this plot
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

## make plot
par(mfrow = c(1,1))
hist(hopoco$Global_active_power,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

## Write png file
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()
