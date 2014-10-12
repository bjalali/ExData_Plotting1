## plot 2: scripts for R code and PNG file.
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
## making plot2
################
png("plot2.png", width = 480, height = 480, units = "px")
plot(dftest$DT, as.numeric(dftest$Global_active_power), 
        ylab="Global Active Power (kilowatts)", xlab="", type="l")
dev.off()
