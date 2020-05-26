#workingpath <- "C:\\Users\\MED1\\Desktop\\Coursera\\project\\GCD"
workingpath <- "C:\\Users\\pc\\Desktop\\Jihan\\GCD"
setwd(workingpath)

x_test <- read.table("./data/test/X_test.txt", colClasses="character")
y_test <- read.table("./data/test/Y_test.txt", colClasses="character")
x_train <- read.table("./data/train/X_train.txt", colClasses="character")
y_train <- read.table("./data/train/Y_train.txt", colClasses="character")
activity <- read.table("./data/activity_labels.txt", colClasses="character")
