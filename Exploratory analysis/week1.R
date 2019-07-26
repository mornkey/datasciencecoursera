library(datasets)
hist(airquality$Ozone) # draw a new plot

with(airquality, plot(Wind,Ozone,pch = 20))  # scatter plot

airqua <- transform(airquality, Month = factor(Month)) # convert month variable from numeric to factor
boxplot(Ozone ~ Month, airqua, xlab = 'Month',ylab='Ozone(ppb)')

# see default values for global graphics parameters
par('pch')

# base plot with annotation
with(airquality, plot(Wind,Ozone,pch=20));title(main='guys did you see this?') # it doesnt hav to run at the same time with plot func

# see data in may in different color
with(airquality,plot(Wind,Ozone),main ='Ozone bitches')
with(subset(airquality, Month==5),points(Wind,Ozone,col='blue')) # add points into the same plot


# or
with(airquality,plot(Wind,Ozone,main = 'Ozone and pals', type = 'n'))
with(subset(airquality,Month==5),points(Wind,Ozone,col='red'))
with(subset(airquality,Month!=5),points(Wind,Ozone,col='black'))
legend('topright',pch = 1,col=c('red','black'),legend = c('May','others'))

# new function : with >> evaluate an R expression in an environment constructed from data

mtcars$mpg[mtcars$cyl == 8  &  mtcars$disp > 350]
with(mtcars,mpg[cyl==8 & disp>350]) # same as above but nicer

# scatter plot with regression line
with(airquality,plot(Wind,Ozone,pch=20,main = 'Ozone baby'))
model <- lm(Ozone~Wind,airquality)
abline(model,lwd=2.5,col='green')

# plot more than 1 plots
par(mfrow=c(2,1)) # mfrow tells to plot row-wise, c(2,1) means 2 rows 1 columns
with(airquality,{
  plot(Wind,Ozone,main = 'Ozone & Wind',pch=20)
  abline(lm(Ozone~Wind,airquality),lwd=2.5,col='green')
  plot(Solar.R,Ozone,main='Ozone & Radiation',pch=20)
  abline(lm(Ozone~Solar.R,airquality),lwd=2.5,col='red')
})

# one more example
par(mfrow=c(1,3))
with(airquality,{
  plot(Wind,Ozone,main='Ozone & Wind',pch=20)
  abline(h = 100,col='red',lwd=2.5)
  plot(Solar.R,Ozone,main='Ozone & Radiation',pch=2)
  abline(h = 100,col='red',lwd=2.5)
  plot(Temp,Ozone,main='Ozone & Temperature',pch=5)
  abline(h = 100,col='red',lwd=2.5)
  mtext('Ozone and other variables',outer = T)
})
