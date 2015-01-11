# Get dataset from file
data_file<- read.csv("./UCIdata/household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                     nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
# Possible speed up using fread from data.table package to read in?

# Cast date column string -> date
data_file$Date <- as.Date(data_file$Date, format="%d/%m/%Y")

# Take data between specified days
data_01_02_07 <- subset(data_file, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data_file)

# Convert date format
datetime <- paste(as.Date(data_01_02_07$Date), data_01_02_07$Time)
data_01_02_07$Datetime <- as.POSIXct(datetime)

# Make panelled plot
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data, {
  plot(Global_active_power~Datetime, type="l", 
       ylab="Global Active Power", xlab="")
  plot(Voltage~Datetime, type="l", 
       ylab="Voltage", xlab="datetime")
  plot(Sub_metering_1~Datetime, type="l", 
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2,cex=0.5, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Datetime, type="l", 
       ylab="Global_reactive_power",xlab="datetime")
})

# Save to png and close
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()