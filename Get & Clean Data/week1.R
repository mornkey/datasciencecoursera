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
