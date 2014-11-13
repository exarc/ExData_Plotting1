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

png(file = "plot4.png", w = 480, h = 480)
par(mfrow = c(2, 2))
with(data, {
        plot(Time, Global_active_power,
             type = "l",
             xlab = "",
             ylab = "Global Active Power"
        )
        plot(Time, Voltage,
             type= "l",
             xlab = "datetime",
             ylab = "Voltage"
        )
        with(data, plot(Time, Sub_metering_1,
                        type = "l",
                        xlab = "",
                        ylab = "Energy sub metering"
        ))
        with(data, points(Time, Sub_metering_2, type = "l", col = "red"))
        with(data, points(Time, Sub_metering_3, type = "l", col = "blue"))
        legend("topright",
               lty = c(1,1),
               bty = "n",
               col = c("black", "red", "blue"),
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
        )
        plot(Time, Global_reactive_power,
             type = "l",
             xlab = "datetime",
             )
})
dev.off()