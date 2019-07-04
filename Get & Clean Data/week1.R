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

# reading XML : extensible markup language