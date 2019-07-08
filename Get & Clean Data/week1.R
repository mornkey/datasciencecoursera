file.exists('week1.R')

# download a file from the web
URL <- 'https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD'
download.file(URL,destfile = 'D:/datasciencecoursera/Get & Clean Data/camera.csv',method='curl')
list.files('D:/datasciencecoursera/Get & Clean Data') 

dateDownloaded <- date() # keep track of the date u downloaded the file

# Reading local flat files
# read.table() : reads the data into RAM (big data can cause problems)

cameraData <- read.table('D:/datasciencecoursera/Get & Clean Data/camera.csv',sep = ',',header = TRUE)
head(cameraData)

# reading XML : extensible markup language : frequently used in web scraping
library(XML)
library(RCurl)
URL <- 'https://www.w3schools.com/xml/simple.xml'

xData <- getURL(URL)
doc <- xmlParse(xData)

rootNode <- xmlRoot(doc) # the wrap of whole thing
xmlName(rootNode)

names(rootNode) # 1 layer nested inside of root node

# you can access it like a list using [[]] (note that [] will also come with $)
rootNode[[1]]
rootNode[[1]][[1]] # fist element of the first element of the xml list
rootNode[[1]][[2]]

# extract parts of the file
x<-xmlSApply(rootNode,xmlValue) # get every value in the file // all value in every tags together
y <- xmlSApply(rootNode[[1]],xmlValue)
# if you want to extract more specific component, you have to learn XPATH (another language)
xpathSApply(rootNode,'//name',xmlValue)
xpathSApply(rootNode,'//price',xmlValue)

# do web scraping : go to https://www.espn.com/nfl/team/_/name/bal/baltimore-ravens
# right click >> view source


# reading JSON : javascript object notation
library(jsonlite)
jsonData <- fromJSON('https://api.github.com/users/jtleek/repos') # gets structured dataframe
names(jsonData)
# try names(jsonData$) and you will see that $owner actually score another df
names(jsonData$owner)
jsonData$owner$login

names(jsonData$license)

# you can turn R dataframe into JSON df
myjson <- toJSON(iris,pretty = T)
cat(myjson)
# and convert back to R df
iris2 <- fromJSON(myjson)


# DATA table 
library(data.table)

DT <- data.table(name=c('non','nan','nam'),bt=c('AB','A','A'),age=c(21,21,19))

DT[,weight:=c(72,80,60)]

age_mean <- DT[,mean(age)]
weight_range <- DT[,range(weight)]

combine <- DT[,list(mean(age),range(weight))] # apply different functions to columns
# !!! if you assign Data table to new variable and make changes to one of them
# both will be affected. you have to use copy function

DT2 <- copy(DT)
DT[,age:=c(0,0,0)]

# data table can also perform multiple step functions to create new variables
DT2[,m:={temp<-age+weight;log10(temp+2)}] # m gets the value from last statement which gets value from the statement before
# special variable .N : number of times that a particular group appears
DT <- data.table(x=sample(LETTERS[1:4],100,replace = TRUE))
DT[,.N,by=x]
# another cool thing about data tables is that they have KEYS
DT <- data.table(x=rep(c(LETTERS[1:3]),each=100),y=rnorm(300))
setkey(DT,x)
DT['A']


# test
library(readxl)
data <- read_excel('getdata_data_DATA.gov_NGAP.xlsx',range = cell_cols(7:15))
dat <- data[18:23,]
sum(dat$Zip*dat$Ext,na.rm=T)

library(XML)
library(RCurl)
URL <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml'

xData <- getURL(URL)
doc <- xmlParse(xData)

rootNode <- xmlRoot(doc) # the wrap of whole thing

zip <- xpathSApply(rootNode,'//zipcode',xmlValue)
length(zip[zip == 21231])

library(data.table)
DT <- fread('getdata_data_ss06pid.csv')

system.time(DT[,mean(pwgtp15),by=SEX])
