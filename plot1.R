#preparing data for plots
#number of rows that have to be read calculates roughly: 3 month with 30 days with 24 hours with 60 minutes
fl <- read.table (file = "household_power_consumption.txt", header = TRUE, sep = ";", 
                  nrows = 3*30*24*60, na.strings = "?")
fl$Date <- as.Date (fl$Date, "%d/%m/%Y") #convertion to Date type
fdata <- fl[fl$Date %in% as.Date(c("2007-02-01","2007-02-02")),] #subset period from 2007-02-01 till 2007-02-02

png(filename = "plot1.png", width = 480, height = 480) #set file device

#making plot
with(fdata, hist(Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", 
                 main = "Global Active Power")) 

dev.off() #closing file device
