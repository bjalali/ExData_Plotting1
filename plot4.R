## plot 4: scripts for R code and PNG file.
## the R script works well, but is not super efficient!

unzip("exdata-data-household_power_consumption.zip", exdir = "exdata")
## to have the column names:
namecol <- read.table("exdata/household_power_consumption.txt", 
                      colClasses="character", nrows=1, header=T, sep=";")
df <- read.table("exdata/household_power_consumption.txt", 
                 colClasses="character", header=T, sep=";")

df$DT <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")

## to find the skip number. 
df[which(df[, "DT"]==as.POSIXlt("2007-02-1 00:00:00")), ]
# skip first 66637-1 line (-1 for the header)

## to find the last needed line. 
nrow(df[which(df[, "DT"] >= as.POSIXlt("2007-02-1 00:00:00") & 
                      df[, "DT"] < as.POSIXlt("2007-02-3 00:00:00" )), ])
# 2880 lines of data to read

## final data to read for plotting:
dftest <- read.table("exdata/household_power_consumption.txt", 
                     colClasses="character", header=T, sep=";", skip=66636, 
                     nrows=2880, col.names=names(namecol))
## add the DT column again as I used read.table again:
dftest$DT <- strptime(paste(dftest$Date, dftest$Time), "%d/%m/%Y %H:%M:%S")

################
## making plot4
################
png("plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2, 2))
plot(dftest$DT, as.numeric(dftest$Global_active_power), 
     ylab="Global Active Power", xlab="", type="l")
plot(dftest$DT, dftest$Voltage, ylab="Voltage", xlab="datetime", type="l")
plot(dftest$DT, dftest$Sub_metering_1, type="l", ylab="Energy sub metering",
     xlab="")
# to add to the existing graph:
lines(dftest$DT,dftest$Sub_metering_2,col="red")
lines(dftest$DT,dftest$Sub_metering_3,col="blue")
legend("topright", col = c("black", "red", "blue"), legend = 
               c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=c(1,1,1))
plot(dftest$DT, dftest$Global_reactive_power, ylab="Global_reactive_power",
     xlab="datetime",type="l")
dev.off()
