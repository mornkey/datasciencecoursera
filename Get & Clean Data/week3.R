df <- data.frame(v1=sample(1:5,10,replace = T),v2=rnorm(10),v3=c(8,3,NA,5,4,NA,NA,10,9,NA))

df[df$v1==1 & df$v2>0,]
df[which(df$v3>0),]

# find position of NA
which(is.na(df$v3))

df[which(!is.na(df$v3)&!is.na(df$v2)),] # fuckin waste of time.. use complete.cases

df[order(df$v3),] # order by 1 column : output from order func. is vector of indices that were ordered by that specific column
df[order(df$v1,df$v2),] # order by 2 columns : order by first argument first then if there're equals, order them by second argument
# ez library for ordering, sorting
library(plyr)
arrange(df,v1) # magic

df <- data.frame(n=rnorm(100))
quantile(df$n) # see quantiles of each field
quantile(df$n,probs = c(0.5,0.75,0.9)) # specify the quantile that you want

df$m <- sample(-5:5,100,replace = T)
df[as.integer(runif(12,1,100)),]$m <- NA
table(df$m,useNA = 'ifany') # see how many times each value appear in the columns
table(df$m,df$n,useNA = 'ifany') # can build 2D table with 2 columns

# check NA
sum(is.na(df$m))
any(is.na(df$m)) # if return TRUE means there're some NAs in there, basically it looks through all the data and see if there's any TRUE
df$age <- as.integer(rnorm(100,13))
all(df$age>0) # see if every sample satisfy the condition e.g. age,weight,height should be positive value
colSums(is.na(df)) ; colSums(df,na.rm = T)

# xtabs : display 1 col grouped by specified factors
data(UCBAdmissions)
df <- as.data.frame(UCBAdmissions)
summary(df)
xtabs(Freq ~ Gender + Admit,data=df) # freakin hard to type that shit
xtabs(Freq ~ Gender + Admit + Dept,data=df)
xt<-xtabs(Freq ~.,data=df) # same as the line before
# you can flat table it
ftable(xt)

print(object.size(df),units = 'Mb') # see obj size in different units


### creating sequences
x <- c(1,3,8,25,100) ; seq(along=x) # generate seq as n of elements in vector
x <- sample(1:5,20,replace = T,prob = c(0.15,0.25,0.18,0.2,0.22))
seq(along=x)

### creating binary variables ifelse() : doesnt have to be 0,1
data(UCBAdmissions)
df <- as.data.frame(UCBAdmissions)
df$fucked <- ifelse(df$Admit=='Admitted','u good','u suck')
xtabs(Freq ~ fucked + Gender,data = df)

# creating categoral variables
df$pt <- cut(df$Freq,breaks = quantile(df$Freq))
table(df$pt,df$Freq)

# melting df
library(reshape)
mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars,id=c('carname','gear','cyl'),measure.vars = c('mpg','hp'))
### melting df is like ... convert columns that r not id and measure to sample values

# casting dataframes
cylData <- dcast(carMelt,cyl ~ variable) # dcast : recast the dataset into a particular shape, see cyl which broken down by different variables
cylData <- dcast(carMelt,cyl ~ variable,mean) # can also pass in a function, to summarize the data in a different way

# averaging values
head(InsectSprays)
tapply(InsectSprays$count, InsectSprays$spray, sum)

# plyr package
library(plyr)
ddply(InsectSprays,.(spray),summarize,sum=sum(count))

# dplyr : specifically designed to help you work with dataframes
# dplyr verbs : arrange, filter, select, mutate, rename, every func take df as first arg

# select : return a subset of the columns of a data frame
# filter : extract a subset of rows from a data frame based on logical conditions
# arrange : reorder rows of a data frame
# rename : rename variables in a data frame
# mutate : add new variables/columns or transform existing variables
# summarise : generate summary statistics of different variables in the data frame, pooibly within strata

library(dplyr) 
m <- select(mtcars,disp:wt) # select only columns from disp to wt
n <- select(mtcars,-(disp:wt)) # select columns except from disp to wt
o <- filter(mtcars,mpg>15) # filter only samples with mpg over 15, quite useful
oo <-filter(mtcars,mpg>17 & qsec<17) # complicating logical statement to get more specific filter

arrange(mtcars,cyl) # arrange data rows by cyl variable
arrange(mtcars,cyl,gear) # multiple variables as arranger

mtcars <- rename(mtcars,cylinder = cyl,milePERgallon = mpg) # rename columns name : new name = old name

mtcars <- mutate(mtcars, dispDetrend = disp-mean(disp,na.rm = T))
mtcars <- mutate(mtcars, fac = factor(1*(dispDetrend>0),levels = c(1,0),labels=c('pos','neg'))) # create new factor variable
n <- group_by(mtcars, fac)
summarize(n,disp=mean(disp),wt_max=max(wt),quan=quantile(qsec,c(0.25))) # summarize data (separated by factors),can only pass in length 1 value

### PIPELINE operator : chain operations together, feed dataset through a pipeline to create a new dataset
# dont need to input 1 arg as df as using PIPELINE operations
mtcars %>% mutate(dispDetrend = disp-mean(disp,na.rm = T)) %>% mutate(fac = factor(1*(dispDetrend>0),levels = c(1,0),labels=c('pos','neg'))) %>% group_by(fac) %>% summarize(disp=mean(disp),wt_max=max(wt),quan=quantile(qsec,c(0.25)))


# merge df
x <- data.frame(id = 1:10,val = sample(rnorm(3),10,replace = T))
y <- data.frame(myId = 1:10,data=seq(0,90,by=10))
z <- merge(x,y,by.x='id',by.y = 'myId')
# or use join in plyr package


### quiz ###
data <- read.csv('getdata_data_ss06hid.csv')
logic <- data$ACR==3 & data$AGS == 6
which(logic)

myurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
z <- tempfile()
download.file(myurl,z,mode="wb")
pic <- readJPEG(z,native = TRUE)
file.remove(z) # cleanup

quantile(pic,c(0.3,0.8))


GDP <- read.csv('getdata_data_GDP.csv')
EDU <- read.csv('getdata_data_EDSTATS_Country.csv')

df <- merge(GDP,EDU,by.x = 'X',by.y = 'CountryCode')
df <- arrange(df,desc(df$Gross.domestic.product.2012))


tapply(as.numeric(df$Gross.domestic.product.2012),df$Income.Group,mean)


