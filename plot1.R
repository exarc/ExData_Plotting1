if(!file.exists("household_power_consumption.txt")) {
        download.file("https://d396qusza40orc.cloudfront.net/
                              exdata%2Fdata%2Fhousehold_power_consumption.zip",
                      "household_power_consumption.zip",
                      method = "auto")
        unzip("household_power_consumption.zip")
}

header <- read.table("household_power_consumption.txt", sep = ";", nrow = 1)

data <- read.table("household_power_consumption.txt",
                   header = TRUE,
                   sep = ";",
                   skip = 66636,
                   nrow = 2880
)
colnames(data) <- unlist(header)
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$Time <- strptime(paste(data$Date, data$Time), format = "%Y-%m-%d %H:%M:%S")

png(file = "plot1.png", w = 480, h = 480)
hist(data$Global_active_power,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)"
)
dev.off()