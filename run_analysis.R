workingpath <- "C:\\Users\\MED1\\Desktop\\Coursera\\project\\GCD"
#workingpath <- "C:\\Users\\pc\\Desktop\\Jihan\\GCD"
setwd(workingpath)

##### Read train / test data sets and activity labels #####
# read datasets(train & test), subject 
x_train <- read.table("./data/train/X_train.txt", colClasses="character")
y_train <- read.table("./data/train/Y_train.txt", colClasses="character")
subject_train <- read.table("./data/train/subject_train.txt", colClasses="character")

x_test <- read.table("./data/test/X_test.txt", colClasses="character")
y_test <- read.table("./data/test/Y_test.txt", colClasses="character")
subject_test <- read.table("./data/test/subject_test.txt", colClasses="character")

# Merge the read train, test & subject data
# and sort the data as the subject name & label
train.data <- cbind(subject_train, y_train, x_train)
test.data <- cbind(subject_test, y_test, x_test)

total.data <- rbind(train.data, test.data)
total.data <- total.data[order(total.data[,1], total.data[,2]),]

##### Read feature data & extract the mean & standard deviation #####
# Read activity & feature data
activity <- read.table("./data/activity_labels.txt", colClasses="character")
features <- read.table("./data/features.txt", colClasses="character")
t.f <- c(rep("t", 265), rep("f", 554-265), rep("angle", 7))
features[,2][1:554] <- substring(features[,2][1:554], first=2)
# split the variable - related mean & std 
feat.split <- strsplit(features[,2], split="-")
fillND <- function(x){
  len.x <- length(x)
  if(len.x <3){
    x <- c(x, rep("not defined", 3-len.x))
  }
  return(x)
}

df.features <- data.frame( features[,1], t.f,
                           matrix(unlist(lapply(feat.split, fillND)), ncol=3, byrow=TRUE) )
names(df.features) <- c("num", "t.f", "name", "variable", "axis")

# find indices of the mean & std 
mean.id <- which(df.features$variable=="mean()")
std.id <- which(df.features$variable=="std()")

meanstd.id <- sort(c(mean.id, std.id))
meanstd.data <- total.data[, c(1, 2, meanstd.id+2)]
meanstd.data[,2] <- as.numeric(meanstd.data[,2])
activity[,1] <- as.numeric(activity[,1])

# label the variable names
meanstd.data[,2] <- activity[,2][meanstd.data[,2]]
meanstd.data[,-2] <- sapply(meanstd.data[,-2], as.numeric)

colnames(meanstd.data) <- c("Subject", "Activity", features[,2][meanstd.id])

##### Result data with the average values of each variables
library(reshape2)
data.long <- melt(meanstd.data, id.var=c("Subject", "Activity"),
				  variable.name="variable", value.name="score")
ave.data <- dcast(data.long, Subject + Activity ~ variable, mean, value.var="score")
write.table(ave.data, "result_ave.txt", sep=" ", row.names=FALSE)
