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

#Step 2: Make plot 1
png("plot1.png", width = 480, height = 480)
hist(electric$Global_active_power, 
     col = 'red', 
     xlab = 'Global Active Power (kilowatts)',
     main = 'Global Active Power')
dev.off()
