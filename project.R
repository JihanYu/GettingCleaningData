workingpath <- "C:\\Users\\MED1\\Desktop\\Coursera\\project\\GCD"
#workingpath <- "C:\\Users\\pc\\Desktop\\Jihan\\GCD"
setwd(workingpath)

activity <- read.table("./data/activity_labels.txt", colClasses="character")

x_train <- read.table("./data/train/X_train.txt", colClasses="character")
y_train <- read.table("./data/train/Y_train.txt", colClasses="character")
subject_train <- read.table("./data/train/subject_train.txt", colClasses="character")
train_data <- cbind(subject_train, y_train, x_train)

body_acc_x_train <- read.table("./data/train/Inertial Signals/body_acc_x_train.txt", colClasses="character")
body_acc_y_train <- read.table("./data/train/Inertial Signals/body_acc_y_train.txt", colClasses="character")
body_acc_z_train <- read.table("./data/train/Inertial Signals/body_acc_z_train.txt", colClasses="character")
body_gyro_x_train <- read.table("./data/train/Inertial Signals/body_gyro_x_train.txt", colClasses="character")
body_gyro_y_train <- read.table("./data/train/Inertial Signals/body_gyro_y_train.txt", colClasses="character")
body_gyro_z_train <- read.table("./data/train/Inertial Signals/body_gyro_z_train.txt", colClasses="character")
total_acc_x_train <- read.table("./data/train/Inertial Signals/total_acc_x_train.txt", colClasses="character")
total_acc_y_train <- read.table("./data/train/Inertial Signals/total_acc_y_train.txt", colClasses="character")
total_acc_z_train <- read.table("./data/train/Inertial Signals/total_acc_z_train.txt", colClasses="character")


x_test <- read.table("./data/test/X_test.txt", colClasses="character")
y_test <- read.table("./data/test/Y_test.txt", colClasses="character")
subject_test <- read.table("./data/test/subject_test.txt", colClasses="character")
test_data <- cbind(subject_test, y_test, x_test)

body_acc_x_test <- read.table("./data/test/Inertial Signals/body_acc_x_test.txt", colClasses="character")
body_acc_y_test <- read.table("./data/test/Inertial Signals/body_acc_y_test.txt", colClasses="character")
body_acc_z_test <- read.table("./data/test/Inertial Signals/body_acc_z_test.txt", colClasses="character")
body_gyro_x_test <- read.table("./data/test/Inertial Signals/body_gyro_x_test.txt", colClasses="character")
body_gyro_y_test <- read.table("./data/test/Inertial Signals/body_gyro_y_test.txt", colClasses="character")
body_gyro_z_test <- read.table("./data/test/Inertial Signals/body_gyro_z_test.txt", colClasses="character")
total_acc_x_test <- read.table("./data/test/Inertial Signals/total_acc_x_test.txt", colClasses="character")
total_acc_y_test <- read.table("./data/test/Inertial Signals/total_acc_y_test.txt", colClasses="character")
total_acc_z_test <- read.table("./data/test/Inertial Signals/total_acc_z_test.txt", colClasses="character")


features <- read.table("./data/features.txt", colClasses="character")
t.f <- c(rep("t", 265), rep("f", 554-265), rep("angle", 7))
features[,2][1:554] <- substring(features[,2][1:554], first=2)
feat.split <- strsplit(features[,2], split="-")
fillNA <- function(x){
  len.x <- length(x)
  if(len.x <3){
    x <- c(x, rep(NA, 3-len.x))
  }
  return(x)
}

df.features <- data.frame( features[,1], t.f,
                           matrix(unlist(lapply(feat.split, fillNA)), ncol=3, byrow=TRUE) )
names(df.features) <- c("num", "t.f", "name", "variable", "axis")

mean.id <- which(df.features$variable=="mean()")
std.id <- which(df.features$variable=="std()")

train.data <- cbind(subject_train, y_train, x_train)
test.data <- cbind(subject_test, y_test, x_test)

total.data <- rbind(train.data, test.data)
total.data <- total.data[order(total.data[,1], total.data[,2]),]

