pollutantmean <- function(directory, pollutant, id=1:332){
  dir = c('D:/datasciencecoursera',directory)
  dir = paste(dir,collapse = "/")
  filelist = list.files(dir)
  value = c()
  for (i in id){
    dir = c('D:/datasciencecoursera',directory,filelist[i])
    dir = paste(dir,collapse = "/")
    MyData <- read.csv(file=dir)
    # execute mean
    if(pollutant == 'sulfate'){
      value = c(value,MyData$sulfate)
    }
    else if( pollutant == 'nitrate'){
      value = c(value,MyData$nitrate)
    }
  }
  mean(value,na.rm = T)
  
}
# test case
# pollutantmean(directory='specdata',id=23,pollutant = 'nitrate')



