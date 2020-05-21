workingpath <- "C:\\Users\\MED1\\Desktop\\Coursera\\project\\GCD"
setwd(workingpath)

##### Problem 1 #####
fileURL1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
if(!file.exists("data") & !file.exists("./data/prob1.csv")){
	dir.create("data")
}
download.file(fileURL1, "./data/prob1.csv", method="curl")

prob1.data <- read.csv("./data/prob1.csv", header=TRUE)
sum(prob1.data$VAL == 24, na.rm=TRUE)
# 53

##### Problem 2 #####
# Each tidy data table contains information about only one type of observation


##### Problem 3 #####
fileURL3 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
if(!file.exists("data") & !file.exists("./data/prob3.xlsx")){
	dir.create("data")
}
download.file(fileURL3, destfile="./data/prob3.xlsx", method="curl")
library(xlsx)

# read rows 18-23 & columns 7-15
dat <- read.xlsx("./data/prob3.xlsx", sheetIndex=1, rowIndex=c(18:23), colIndex=c(7:15), header=TRUE)

sum(dat$Zip*dat$Ext,na.rm=T)
# [1] 36534720

##### Problem 4 #####
fileURL4 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
if(!file.exists("data") & !file.exists("./data/prob4.xml")){
	dir.create("data")
}
library(XML)
download.file(fileURL4, destfile="./data/prob4.xml", method="curl")
doc <- xmlTreeParse("./data/prob4.xml", useInternal=TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)

xpathSApply(doc, "//zipcode[@class='21231']", xmlValue)


##### Problem 5 #####
fileURL5 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
if(!file.exists("data") & !file.exists("./data/prob5.csv")){
	dir.create("data")
}
download.file(fileURL5, destfile="./data/prob5.csv", method="curl")
DT <- fread("./data/prob5.csv", header=TRUE)

Rprof("rowMeans")
rowMeans(DT)[DT$SEX==1];  rowMeans(DT)[DT$SEX==2]
Rprof(NULL)

Rprof("DT")
DT[, mean(pwgtp15), by=SEX]
Rprof(NULL)

Rprof("mean.by")
mean(DT$pwgtp15, by=DT$SEX)
Rprof(NULL)

Rprof("sapply")
sapply(split(DT$pwgtp15, DT$SEX), mean)
Rprof(NULL)

Rprof("mean2")
system.time(mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15))
Rprof(NULL)

Rprof("tapply")
system.time(tapply(DT$pwgtp15, DT$SEX, mean))
Rprof(NULL)

summaryRprof("rowMeans")
summaryRprof("DT")
summaryRprof("mean.by")
summaryRprof("sapply")
summaryRprof("mean2")
summaryRprof("tapply")


rowMeans(DT)[DT$SEX==1];  rowMeans(DT)[DT$SEX==2]
DT[, mean(pwgtp15), by=SEX]
mean(DT$pwgtp15, by=DT$SEX)
sapply(split(DT$pwgtp15, DT$SEX), mean)
mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)
tapply(DT$pwgtp15, DT$SEX, mean)

