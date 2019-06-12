# factor
x <- factor(c('Mage','Bruiser','Tank','Assasin','AD range','Jungler','Support'),
            levels = c('Bruiser','Tank','Jungler','Mage','Assasin','AD range','Support'))
# missing value
miss <- c(1,2,3,NaN,4,5) # NaN is NA but NA is not NaN

v <- matrix(nrow = 5,ncol = 3, data = 1:15)

# dataframe
df <- data.frame(even = c(2,4,6,8,10),odd = c(1,3,5,7,9))
df$even

# all R objects have a name! we can name every element 
y <- 1:3
names(y)<- c('first','second','third')

# matrix can have dim name
m <- matrix(1:4,nrow = 2,ncol = 2)
dimnames(m)<- list(c('a','b'),c('c','d'))

# dput
dput(df,file = 'df.R')
new.df <- dget('df.R') # dget can be used on single object

# dump can be used on multiple objects ( multiple dput in one)
name <- c('nontapat','nantapon')
nondf <- data.frame(grade=c(3.2,3,2.8,2.9),subject=c('math','physics','social','arts'))
dump(c('name','nondf'),file = 'shit.R')
rm(name,nondf)
source('shit.R') # read those value back!

# read file
library(readxl)
data <- read_excel('mp61_excel230261_20180405_120432.xls', n_max = 600)

# extract subset of R objects
l <- c('a','z','h','u','r','p','q')
l[l>'p'] # extract by logical
u <- l >'p' # logical vector
x <- list(name1 = 1:4,name2 = 0.6,name3 = 'shit') # extract from list
x['name1']
x[['name1']]
x[['name1']][1]
x[c(1,3)] # extract specific elements of the list
x$name1[c(1,3)] # extract sub specific elements of the list
x[[c(1,2)]] # same 


# $ is not replaceable!
x$name1
n <- 'name1'
x$n # results in NULL
x[[n]] # works

# partial matching
y <- list(bitch = 1:5, rekt = 6:12)
y$b # $ can do partial matching
y[['b',exact=FALSE]] # [[]] also can but with exact = FALSE 

# removing NA value by creating logical vector
x <- c(1,2,NA,5,6,NA)
bad <- is.na(x)
x[!bad]

# removing NA from multiple elements
x<-c(1,2,NA,3,4,5,NA)
y<-c('a',NA,'p','z',NA,NA,'t')
good <- complete.cases(x,y) # complete.cases need same length elements // can also be used with df

data <- read.csv('hw1_data.csv')

yea <- data$Ozone > 31

five <- data$Month == 5

max(data$Ozone[five])

max(data$Ozone[five],na.rm = TRUE)

# swirl 1 basic building blocks : basic, c(), elementwise operations
# swirl 2 workspace, manage files, dir programmatically
# swirl 3 create sequence of numbers, elements using :,seq(),seq_along(),rep()
