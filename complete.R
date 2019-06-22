complete <- function(directory, id = 1:332){
  dir = c('D:/datasciencecoursera',directory)
  dir = paste(dir,collapse = "/")
  filelist = list.files(dir)
  # loop through
  df <- data.frame(matrix(ncol = 2, nrow = 0))
  colnames(df)<-c('id','nobs')
  
  for (i in id){
    dir = c('D:/datasciencecoursera',directory,filelist[i])
    dir = paste(dir,collapse = "/")
    MyData <- read.csv(file=dir)
    sum <- sum(complete.cases(MyData))
    df2 <- data.frame(i,sum)
    df <- rbind(df,df2)
  }
    
  return(df)
}





