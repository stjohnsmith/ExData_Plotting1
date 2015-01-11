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

# Make overlaid plot
with(data, {
  plot(Sub_metering_1~Datetime, type="l",
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1.0, lwd=2, cex=0.66,
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Save to png and close
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()