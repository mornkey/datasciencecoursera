y_train <- read.delim("./UCI HAR Dataset/train/y_train.txt",header = FALSE)
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt",header = FALSE)

y_test <- read.delim("./UCI HAR Dataset/test/y_test.txt",header = FALSE)
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt",header = FALSE)

feature <- read.delim('./UCI HAR Dataset/features.txt', header = FALSE, sep = "\t")
colnames(x_train) <- feature[1:561,]
colnames(x_test) <- feature[1:561,]

# 1.Merges the training and the test sets to create one data set.
x <- rbind(x_train,x_test)
y <- rbind(y_train,y_test)

# get only mean() and std() from feature
id <- grep('mean[[:punct:]]{2}|std[[:punct:]]{2}',feature[1:561,])
data <- x[,id] # 66 columns remain

# convert y value to descriptive name
factor <- read.delim('./UCI HAR Dataset/activity_labels.txt',header = FALSE)
factor <- as.data.frame(factor(y[,],labels=factor[,]))
colnames(factor) <- 'y'
factor[,] <- gsub('\\d[[:space:]]',"",factor[,])

# combine x and y
data <- cbind(factor,data)
df<- data.frame(matrix(nrow = 6))
for(i in 2:67){
  temp <- tapply(data[,i],data[,1],mean)
  df <- cbind(df,temp)
}
df$matrix.nrow...6.<-NULL
colnames(df) <- colnames(data[,2:67])

write.table(df,file = "dataset.txt",row.names = FALSE)
