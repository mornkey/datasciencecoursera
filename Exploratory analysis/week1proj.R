# course project

data <- read.delim('./household_power_consumption.txt',sep = ';',colClasses = 'character')
# data$Date <- as.Date(data$Date,'%d/%m/%Y')

datetime <- paste(data$Date,data$Time)
data$datetime <- as.POSIXlt(datetime, format="%d/%m/%Y %H:%M:%S")

timespand <- c('2007-02-01','2007-02-03')
x <- data[data$datetime>=as.POSIXlt(timespand[1]) & data$datetime < as.POSIXlt(timespand[2]),]

png(filename='plot1.png',width = 480,height = 480)
barplot(table(cut(as.numeric(x$Global_active_power), breaks = seq(0,7.5,by=0.5))),space = 0,axisnames = FALSE,col = 'red')
title(main = 'Global Active Power',xlab = 'Global Active Power (kilowatts)',ylab = 'Frequency')
axis(side=1,at=c(0,4,8,12),labels=c(0,2,4,6))
dev.off()

# 2nd plot
png('plot2.png')
plot(x$datetime, x$Global_active_power,type='l',ylab='Global Active Power (kilowatts)',xlab='')
dev.off()

# 3rd plot
png('plot3.png')
with(x,{
  plot(datetime,Sub_metering_1,type = 'l',ylab = 'Energy sub metering',xlab='')
  points(datetime,Sub_metering_2,type='l',col='red')
  points(datetime,Sub_metering_3,type='l',col='blue')
  legend('topright',legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),col=c('black','red','blue'),lty=1)
})
dev.off()

# 4th plot
png('plot4.png')
par(mfcol=c(2,2))
with(x,{
  plot(x$datetime, x$Global_active_power,type='l',ylab='Global Active Power (kilowatts)',xlab='')
  plot(datetime,Sub_metering_1,type = 'l',ylab = 'Energy sub metering',xlab='')
  points(datetime,Sub_metering_2,type='l',col='red')
  points(datetime,Sub_metering_3,type='l',col='blue')
  legend('topright',legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),col=c('black','red','blue'),lty=1)
  plot(datetime,Voltage,type='l',xlab = 'datetime',ylab = 'Voltage')
  plot(datetime,Global_reactive_power,type='l',xlab = 'datetime',ylab = 'Global_reactive_power')
})
dev.off() 
  
