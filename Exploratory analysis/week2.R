library(lattice)

airquality <- transform(airquality,Month = factor(Month))
p <- xyplot(Ozone~Wind|Month,data = airquality,layout=c(5,1))
class(p)
library(nlme)
library(lattice)
xyplot(weight ~ Time | Diet, BodyWeight)

# panel
x <- rnorm(100)
f <- rep(0:1, each=50)
y <- x + f - f*x + rnorm(100,sd=0.5)
f <- factor(f, labels = c('0','1'))
xyplot(y~x | f,layout=c(1,2)) # not using panel yet

# PANEL
xyplot(y~x|f,panel = function(x,y,...){
  panel.xyplot(x,y,...)
  panel.abline(h=median(y),lty = 2)
})

# ggplot2 plotting system
library(ggplot2)
qplot(votes, rating, data = movies,smooth = 'loess')

qplot(data=mpg,displ,hwy,color= drv)

qplot(data=mpg,displ,hwy,geom = c('point','smooth')) # 95% confidence intervals for that line are indicated by the gray zone
qplot(data=mpg,displ,hwy,color= drv,geom = c('point','smooth'))

qplot(data=mpg,hwy) # input 1 arg automatically plot histogram COOL
qplot(data=mpg,hwy,fill=drv)

# facets, like panels in lattice plot
qplot(data=mpg,hwy,facets = .~drv,fill=drv) # .row & n drv columns facets variable takes left & right separated by ~
qplot(data=mpg,hwy,facets = drv~.,fill=drv) # n drv row & .columns

qplot(data=mpg,hwy,facets = drv~class,fill=drv) # 2 facets variables !! dope. with drv as row and class as column
qplot(data=mpg,displ,hwy,facets = drv~class,color=drv)

# density plot
qplot(data = mpg,log(hwy),geom = c('density'),facets = .~drv,fill=drv)

# scatter plot
qplot(data=mpg,displ,hwy,color=class,shape=drv,size=1) # a lil to hard to look and interpret any info

# ggplot by adding up elements, not qplot
x <- mtcars
qplot(mpg,qsec,data=x,facets = cyl~.,geom=c('point','smooth'),method='lm')
# rebuild the plot above with ggplot
g <- ggplot(data = x,aes(mpg,qsec)) # there's no plot YET!
summary(g)

p <- g + geom_point(color='blue',size=4,alpha=0.5) # modify aesthetic : set to constant
p # there we go, the points appeared
p <- g + geom_point(aes(color=vs),size=1.5,alpha=0.8) # or set it to variable by aes() : aesthetic mapping
p

p + geom_smooth(method = 'lm',size=2,linetype=3,se=F) + facet_grid(vs~.) # confident bound se = T

# change bg theme : fuck yea this is fun
p + geom_smooth(method = 'lm',size=1,linetype=1) + theme_bw() # looks hell of a lot better
p + geom_smooth(method = 'lm',size=1,linetype=3,color='yellow') + theme_dark()
p + geom_smooth(method = 'lm',size=1,linetype=1) + theme_classic()
p + geom_smooth(method = 'lm',size=1,linetype=1) + theme_light()

# set axis limits : in some cases you dont want several outliers to harden your time tryin to view the overall data in the plot
ez <- data.frame(x=1:100,y=rnorm(100))
ez[50,2] = 100
g <- ggplot(ez,aes(x,y))
g + geom_line() # as you can see. that 1 datapoint just ruin everything

g + geom_line(size=0.5) + ylim(-4,4) # this works but it will take away anything that is out of limit : u can see the line is discontinued
g + geom_line(size=0.5) + coord_cartesian(ylim=c(-4,4)) # this is better :)

# categorize continuous variable into factor of range
cutpoints <- quantile(x$hp,seq(0,1,length=5))
x$hpfac <- cut(x$hp,cutpoints)
levels(x$hpfac)

g <- ggplot(x, aes(hp,mpg))
g + geom_point(aes(color=hpfac)) + facet_grid(.~hpfac) + theme_light()
