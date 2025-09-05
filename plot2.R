# Step 1: Load the .txt file and clean data
# Assign list of column names
header <- read.table("files/household_power_consumption.txt", 
                     sep = ";", header = TRUE, nrows = 1)

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
png("plot2.png", width = 480, height = 480)
plot(electric$DateTime, electric$Global_active_power,
     type = 'l',
     xaxt = 'n',
     xlab = '',
     ylab = 'Global Active Power (kilowatts)')
axis(1, at=seq(min(electric$DateTime), max(electric$DateTime)+86400, by="day"),
     labels=weekdays(seq(min(electric$DateTime), max(electric$DateTime)+86400, by="day"), abbreviate=TRUE))
dev.off()
