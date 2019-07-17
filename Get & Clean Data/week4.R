# fixing character variables

URL <- 'https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD'
download.file(URL,destfile = './camera.csv',method = 'curl')
data <- read.csv('camera.csv')
names(data)

tolower(names(data)) # convert characters to lowercases
toupper(names(data))# convert characters to uppercases

x <-strsplit(names(data),'\\.')
x[6] # split 'location.1' to 'location' and '1' , output as list
x[[6]][1] # call the first string which is 'location'
x[[6]][2]

# useful string functions
library(stringr)
nchar('nontapat sumalnop') # 17
nchar('nontapatsumalnop') # 16, spaces also counted as 1 cha

substr('nontapat sumalnop',1,8) # "nontapat", take out only pos 1:8

paste('nontapat','sumalnop',sep = '-') # "nontapat-sumalnop"
paste0('nontapat','sumalnop') # "nontapatsumalnop" , default to no space

str_trim('       nontapat   ') # "nontapat" , trim out extra spaces at the beginning and the end

# names of variables should be !
# lower cases when possible, easy to read and understand, no duplicate, dont have characters like _ . , or white spaces
# variables with characer values : should be made into factor variables

### working with DATES
d <- date() # gives date and time : "Wed Jul 17 13:44:23 2019"
class(d) # character
d2 <- Sys.Date() # gives only date : "2019-07-17"
class(d2) # class : Date

# formatting dates
# %d : day as number(0-31), %a : abbreviated weekday (Mon,Wed etc.), %A : unabbreviated weekday
# %m : month as number (00-12), %b : abbreviated month, %B : unabbreviated month
# %y : 2 digits year, %Y : four digits year

format(d2,'%a%b%d') # can use with or without spaces
format(d2,'%a %d %b %Y')

# take vector of strings and convert as date
x <- c('1jan1960','2jan1995','27oct1997');z <- as.Date(x,'%d%b%Y') # as.Date takes input as pattern of text you want to convert but the output is formatted in the form of %Y-%m-%d
format(z,'%a %d %b %Y') # take output from as.Date as input of format()

x <- c('1jan1960','2jan1995','27oct1997');z <- as.Date(x,'%d%b%Y');format(z,'%a %d %b %Y')
y <- c('1-oct-2001','7-aug-1997');z <- as.Date(y,'%d-%b-%Y');format(z,'%a %d %b %Y')

# date objects can perform these operation like ...
z[1]-z[2] # Time difference of 1516 days
as.numeric(z[1]-z[2]) # 1516

z[2]-z[1] # Time difference of -1516 days
as.numeric(z[2]-z[1]) # -1516

# converting to Julian ...
weekdays(z)
months(z)
julian(z) # number of days since the origin

# Lubridate package
library(lubridate)
x <- c('2014.01.08','2010-10-22'); ymd(x) # any . / - or spaces will no longer troubles you anymore
x <- c('08/04/1989');mdy(x)
x <- c('27-10-1997','07 08 1997') ; dmy(x)

x <- Sys.time();ymd_hms(x)
ymd_hms('2011 08 03 10:15:03',tz='Asia/Bangkok') # can also set time zone
Sys.timezone() # find your time zone

# Free Data Resource : see in dir


