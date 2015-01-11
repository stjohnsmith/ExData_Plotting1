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

# Make histogram plot of data
hist(data_01_02_07$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

# Save to png and close
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()