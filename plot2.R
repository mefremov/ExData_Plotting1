#preparing data for plots
#number of rows that have to be read calculates roughly: 3 month with 30 days with 24 hours with 60 minutes
fl <- read.table (file = "household_power_consumption.txt", header = TRUE, sep = ";", 
                  nrows = 3*30*24*60, na.strings = "?")
fl$Fulldate <- paste(fl$Date, fl$Time) #add new colunm with full date
fl$Date <- as.Date (fl$Date, "%d/%m/%Y") #convertion to Date type
fdata <- fl[fl$Date %in% as.Date(c("2007-02-01","2007-02-02")),] #subset period from 2007-02-01 till 2007-02-02
fdata$Fulldate <- strptime (fdata$Fulldate, "%d/%m/%Y %H:%M:%S") #convert types

png(filename = "plot2.png", width = 480, height = 480) #set file device

#making plot
with(fdata, plot(Fulldate, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", 
                 xlab = "", axes = FALSE))
box(col = "gray50") #making box around the plot another color than black
axis.POSIXct(1, fdata$Fulldate,col = "black") #creating x-axis, use time-axis
axis(2, col = "black") #creating y-axis

dev.off() #closing file device
