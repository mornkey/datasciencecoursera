makeVector <- function(x = numeric()){
  m <- NULL
  set <- function(y){
    x <<- y # grab x from makeVector environment and set it to y
    m <<- NULL
  }
  get <- function() x # wtf
  setmean <- function(mean) m <<- mean
  getmean <- function() m
  list(set = set,get = get, setmean = setmean, getmean = getmean) # this line gets returned
  
}


cachemean <- function(x, ...){
  m <- x$getmean() # gets the value from function 'getmean in the list
  if(!is.null(m)){
    message('getting cache data')
    return(m)
  }
  data <- x$get()
  m <- mean(data,...)
  x$setmean(m)
  m
}

# so.. you basically create the vector that u wanna cache with makevector func
# then you can input that into cachemean func once , it will calculate the mean
# of that vector. but if you called it twice, i will return the cache of that mean
# instead of calculating it again! >> good application im sure

# try very big vector


