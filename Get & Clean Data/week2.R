# READ from SQL
library(RMySQL)
ucscDB <- dbConnect(MySQL(),user='genome',host='genome-mysql.cse.ucsc.edu')
result <- dbGetQuery(ucscDB,'show databases;');dbDisconnect(ucscDB) # show databases; is SQL command, you should get TRUE respond from disconnect command

hg19 <- dbConnect(MySQL(),user='genome',db='hg19',host='genome-mysql.cse.ucsc.edu')
allTables <- dbListTables(hg19) # get list of tables in hg19 database, 1 sql server can hold many databases
length(allTables)
allTables[1:5] # list out first 5 tables
dbListFields(hg19,'HInv') # get field from table
dbGetQuery(hg19,'select count(*) from HInv'); dbDisconnect(hg19) # return number of sample from the table
HInvData <- dbReadTable(hg19,'HInv'); dbDisconnect(hg19)
# now we have HInv dataframe into R
head(HInvData)

# select a specific subset : sometimes you want to read in particular part of data because SQL can store very BIG data
hg19 <- dbConnect(MySQL(),user='genome',db='hg19',host='genome-mysql.cse.ucsc.edu')
query <- dbSendQuery(hg19,'select * from affyU133Plus2 where misMatches between 1 and 3')
affyMis <- fetch(query); quantile(affyMis$misMatches)
affyMisSmall <- fetch(query,n=10); dbClearResult(query)

library(data.table)
library(RMySQL)
DB <- dbConnect(MySQL(),user='genome',db='hg19',host='genome-mysql.cse.ucsc.edu')
tables <- dbListTables(DB) # you have to select Database
dbListFields(DB,'HInvGeneMrna')
HInvGeneMrna <- dbReadTable(DB,'HInvGeneMrna'); dbDisconnect(DB)
HInvGeneMrna <- as.data.table(HInvGeneMrna)

dbDisconnect(DB)
result <- dbGetQuery(DB,'show databases;'); dbDisconnect(DB)

# HDF5 : used for storing large datasets, supports storing a rnge of data types
# heirarchical data format : data stored in groups which contains zero or more datasets along with their metadata
# each of  these groups has a group header with the group name and a list of attribuites corresponding to that group
# also have a group symbol table which has a list of the objects in the group
# datasets multidimensional array of data elements with metadata
# have a header with name, datatype, dataspce and storage layout
# have a data array with the data

# install R HDF5 package
library(rhdf5)
created = h5createFile('ex.h5')
created = h5createGroup('ex.h5','foo')

h5ls('ex.h5') # list out elements in hdf5 file

# write to groups
a <- matrix(1:20,4,5)
h5write(a,'ex.h5','foo/a')
h5ls('ex.h5')

b <- array(seq(0.1,2.0,by=0.1),dim = c(5,2,2))
attr(b,'scale') <- 'liter'

h5write(b,'ex.h5','foo/foobaa/b')
h5ls('ex.h5')

df <- data.frame(1L:5L,seq(0,1,length.out = 5),c('ab','cde','fghi','a','s'), stringsAsFactors = F)
# what's the different in 1 and 1L : you can use it to get your code to run faster and consume less memory
# A double ("numeric") vector uses 8 bytes per element. An integer vector uses only 4 bytes per element.
x <- 1:100
y <- x+1
typeof(y) # double >> twice the memory size
object.size(y) # 848 bytes

z <- x+1L
typeof(z) # integer >> still integer which is less memory
object.size(z) # 448

h5write(df,'ex.h5','foo/f')
h5ls('ex.h5')

# read h5 object
h5read('ex.h5','/foo/a')
h5read('ex.h5','/foo/foobaa')

### read and write in chunks : write in specific index
h5write(c(12L:15L),'ex.h5','foo/a',index=list(1:4,2)) # replace row 1:4 column 2 with 12 13 14 15
h5read('ex.h5','foo/a',index=list(1:4,3)) # read in specific index

### reading from the web : web scraping

# web scraping : programmatically extracting data from the HTML code of websites or URL
# in some cases this is against the terms of service for the website, attempting to read too many pages too quickly can get your IP address blocked

# use httr package, others are readLines, XML package but didnt work for me
library(httr); html <- GET(url = "http://finance.yahoo.com/q/op?s=DIA&m=2013-07")
content = content(html,as='text')
parsedHtml <- htmlParse(content,asText = TRUE)
xpathApply(parsedHtml,'//title',xmlValue)

# accessing websites with passwords
pg1 <- GET('http://httpbin.org/basic-auth/user/passwd')

pg1 # not able to login because havent been authenticated
# Response [http://httpbin.org/basic-auth/user/passwd]
# Date: 2019-07-08 10:33
# Status: 401
# Content-Type: <unknown>
#   <EMPTY BODY>

# BUT!! with httr package you can authenticate yourself
pg2 <- GET('http://httpbin.org/basic-auth/user/passwd',authenticate('user','passwd'))
pg2 # authenticated ! see the respond!
names(pg2)

# using handles : you authenticate this handle 1 time then the cookies will stay with this handle and you will be authenticated, you dont have to keep authenticating over and over again as you access the website 
google <- handle('http://google.com') 
pg1 <- GET(handle = google,path='/')
pg2 <- GET(handle=google,path='search') 
