# function
above <- function(x, n = 7){ # set default number
  use <- x>n # create logical vector VERY EZ :-O
  return(x[use]) # use logical vector as INDEX
}

# calculate mean of each column
col_mean <- function(df, removeNA = TRUE){
  nc <- ncol(df) # get n of columns to iterate for loop
  means <- numeric(nc) # create numeric vector with the length of nc, initial filled as 0
  for (i in 1:nc){
    means[i] <- mean(df[,i], na.rm = removeNA)
  }
  return(means)
  
}
