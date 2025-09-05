# EXPLORATORY DATA ANALYSIS - ASSIGNMENT 1

# Step 1: LOADING THE DATA

# Step 1a: Download and unzip the files
url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
dest <- 'files.zip'
if (!file.exists(dest)) {
  message("File not found — downloading...")
  download.file(url, dest, mode = "wb")
} else {
  message("File exists. Skip download")
}
zipdir <- 'files'
if (!dir.exists(zipdir)) {
  message("Unzipping...")
  unzip(dest, exdir = zipdir)
} else {
  message("Folder already exists — skipping unzip.")
}

# Step 1b: Load the .txt file and clean data
# Read the table
electric <- read.table("files/household_power_consumption.txt", 
                       header = TRUE, sep = ";")
# Convert to Date/Time format
electric$DateTime <- as.POSIXct(paste(electric$Date, electric$Time),
                                format = "%d/%m/%Y %H:%M:%S")
