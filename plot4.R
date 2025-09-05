# Assign condition to read rows
rows <- grep("^[12]/2/2007", readLines("files/household_power_consumption.txt"))

# Read only rows with assigned conditions
electric <- read.table("files/household_power_consumption.txt", 
                       sep = ";", skip = rows[1] - 1, nrows = length(rows), 
                       header = FALSE)

# Match column names with "header"
names(electric) <- names(header)

# Convert to Date/Time format
electric$DateTime <- as.POSIXct(paste(electric$Date, electric$Time),
                                format = "%d/%m/%Y %H:%M:%S")

#Step 2: Make plot 2
#Change to weekday format
electric$weekday <- weekdays(electric$DateTime, abbreviate = TRUE)

#Make plot
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2)) #2 x 2 layout
plot(electric$DateTime, electric$Global_active_power,
     type = 'l',
     xaxt = 'n',
     xlab = '',
     ylab = 'Global Active Power')
axis(1, at=seq(min(electric$DateTime), max(electric$DateTime)+86400, by="day"),
     labels=weekdays(seq(min(electric$DateTime), max(electric$DateTime)+86400, by="day"), abbreviate=TRUE))

plot(electric$DateTime, electric$Voltage,
     type = 'l',
     xaxt = 'n',
     xlab = 'datetime',
     ylab = 'Voltage')
axis(1, at=seq(min(electric$DateTime), max(electric$DateTime)+86400, by="day"),
     labels=weekdays(seq(min(electric$DateTime), max(electric$DateTime)+86400, by="day"), abbreviate=TRUE))

plot(electric$DateTime, electric$Sub_metering_1,
     type = 'l',
     xaxt = 'n',
     xlab = '',
     ylab = 'Energy sub metering')
lines(electric$DateTime, electric$Sub_metering_2,
      type = 'l',
      xaxt = 'n',
      col = 'red')
lines(electric$DateTime, electric$Sub_metering_3,
      type = 'l',
      xaxt = 'n',
      col = 'blue')
axis(1, at=seq(min(electric$DateTime), max(electric$DateTime)+86400, by="day"),
     labels=weekdays(seq(min(electric$DateTime), max(electric$DateTime)+86400, by="day"), abbreviate=TRUE))
legend("topright",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black","red","blue"),
       lty=1)

plot(electric$DateTime, electric$Global_reactive_power,
     type = 'l',
     xaxt = 'n',
     xlab = 'datetime',
     ylab = 'Global_reactive_power')
axis(1, at=seq(min(electric$DateTime), max(electric$DateTime)+86400, by="day"),
     labels=weekdays(seq(min(electric$DateTime), max(electric$DateTime)+86400, by="day"), abbreviate=TRUE))
dev.off()
