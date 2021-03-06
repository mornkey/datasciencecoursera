# lapply : argument >> 1 list, 2 function, ... argument to the input function
x <- 1:4
l <- lapply(x, runif,min=0,max=10)
class(l) # return list object

# lapply can also be used with anonymous function
# the function goes away when lapply is over
x <- list(a = matrix(1:4,2,2),b = matrix(1:6,3,2))
# if we want to extract 1st col from these matrix
lapply(x, function(col1) col1[,1])

# sapply will try to simplify the result of lapply if possible
# if list of length 1 element >> vector
# list of vector >> matrix
# cant figure out >> list

summatrix <- sapply(x, sum)

# apply
x <- matrix(rnorm(99),11,9) # rnorm generates random number that can specify stats value : n, mean, std
y <- apply(x, 1, mean) # y return a vector length 11 cuz dimension 1 has 11 rows
z <- apply(x ,2, mean) # z return a vector length 9 cuz dimension 2 has 9 columns

# or you can use simplify function for that ( means, sum)
y2 <- rowMeans(x) # the output is the same as y <- apply(x, 1, mean)
z2 <- colMeans(x)

# use ... argument in apply
a <- apply(x,1,quantile,probs=c(0.25,0.5,0.75))
b <- apply(x,2,quantile,probs=c(0.3,0.7))

# can work with 3d object too
x <- array(rnorm(2*2*10),dim = c(2,2,10))
y <- apply(x,c(1,2),mean)
# rowMeans (and pals) can also do this
y2 <- rowMeans(x,dims = 2) 

# mapply : apply a function to multiple list in parallel
m <- list(rep(1,4),rep(2,3),rep(3,2),rep(4,1))
n <- mapply(rep,1:4,4:1) # same result as above ( different data type )

x <- rnorm(10)
y <- rnorm(5)
z <- rnorm(20)

m <- mapply(quantile,list(x,y,z),list(c(0.25,0.75),c(0.3,0.7),c(0.2,0.8)))
# same as below all tgt
quantile(x,probs = c(0.25,0.75))
quantile(y,probs = c(0.3,0.7))
quantile(z,probs = c(0.2,0.8))

# tapply : apply function to each "GROUP" of data in vector
x <- c(rnorm(10),runif(10),rnorm(10,1))
f <- gl(3,10) # generate factor level indicating which group the observation is in
groupmean <- tapply(x, f, mean) # take mean of each "group" in vector x
grouprange <- tapply(x, f, range)

weightallstu <- c(48,51,52.3,49.5,50,65,71,68,66,63)
group <- gl(2,5)
weightmeanG <- tapply(weightallstu, group, mean)


# split : split take vector or object and split by factor into groups
# can be used to split data before using lapply or sapply
data <- c(rnorm(10),runif(10),rnorm(10,1))
f <- gl(3,10)
data <- split(data,f)
# create feature for data, try these! *** split always return list
data$`1`
data$`2`
data$`3`
class(data) # list of 3 elements (3features)

# you can split on more than 1 level
l1 <- gl(2,5)
l2 <- gl(5,2)
interaction(l1,l2)
# or! u dont have to use interaction
data <- c(rnorm(10),runif(10),rnorm(10,1))
split(data,list(l1,l2)) # you will see some that have 0 elements
split(data,list(l1,l2),drop = T) # now u wont

df <- data.frame(name=c('Non','Nan','Nam','Kai','Ath'),gender=factor(c('M','M','F','F','M')))

# debugging tools,
log(-1) # warning message

# test
library(datasets)
data <- mtcars
# calculate mpg mean ( grouped by cyl )
with(data,tapply(mpg,cyl,mean))
tapply(mtcars$mpg,mtcars$cyl,mean)

