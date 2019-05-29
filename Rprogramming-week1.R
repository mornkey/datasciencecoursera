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


