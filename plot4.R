#preparing data for plots
#number of rows that have to be read calculates roughly: 3 month with 30 days with 24 hours with 60 minutes
fl <- read.table (file = "household_power_consumption.txt", header = TRUE, sep = ";", 
                  nrows = 3*30*24*60, na.strings = "?")
fl$Fulldate <- paste(fl$Date, fl$Time) #add new colunm with full date
fl$Date <- as.Date (fl$Date, "%d/%m/%Y") #convertion to Date type
fdata <- fl[fl$Date %in% as.Date(c("2007-02-01","2007-02-02")),] #subset period from 2007-02-01 till 2007-02-02
fdata$Fulldate <- strptime (fdata$Fulldate, "%d/%m/%Y %H:%M:%S") #convert types

png(filename = "plot4.png", width = 480, height = 480) #set file device

#making plots
par(mfrow = c(2,2)) #set number of plots in canvas
#making plot "GLobal active pover"
with(fdata,  {plot(Fulldate, Global_active_power, ylab = "Global Active Power", xlab = "", 
                   type = "l", axes = FALSE)
              box(col = "gray50") #making box another color than black
              axis(2, col = "black") #creating y-axis
              axis.POSIXct (1, Fulldate, col = "black") #creating x-axis
              }) 
#making plot "Voltage"
with(fdata,  {plot(Fulldate, Voltage, ylab = "Voltage", xlab = "datetime", type = "l", axes = FALSE) 
              box(col = "gray50")
              axis(2, at = seq (234, 246, 2), labels = c(234, "", 238, "", 242, "", 246), col = "black")
              axis.POSIXct (1, Fulldate, col = "black")
              })
#making plot "Energy sub metering"
with(fdata,  {plot(Fulldate, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "", axes = FALSE)
              box(col = "gray50")
              axis(2, col = "black")
              axis.POSIXct (1, Fulldate, col = "black")
              lines(Fulldate, Sub_metering_2, col = "red")
              lines(Fulldate, Sub_metering_3, col = "blue")
              legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
                     col = c("black", "red", "blue"), lty = 1, bty = "n")
              })
#making plot "Global reactive power"
with(fdata,  {plot(Fulldate, Global_reactive_power, , xlab = "datetime", type = "l", axes = FALSE)
              box(col = "gray50")
              axis(2, col = "black")
              axis.POSIXct (1, Fulldate, col = "black")
              })

dev.off() #closing file device