#workingpath <- "C:\\Users\\MED1\\Desktop\\Coursera\\project\\GCD"
workingpath <- "C:\\Users\\pc\\Desktop\\Jihan\\GCD"
setwd(workingpath)

##### Problem 1 #####
fileURL1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
if(!file.exists("data") & !file.exists("./data/prob1.csv")){
	dir.create("data")
}
download.file(fileURL1, "./data/prob1.csv", method="curl")

prob1.data <- read.csv("./data/prob1.csv", header=TRUE)
#AGS==6
#ACR==3
agricultureLogical <- which((prob1.data$ACR==3) & (prob1.data$AGS==6))
head(agricultureLogical, 3)
#[1] 125 238 262

##### Problem 2 #####
library(jpeg)
fileURL2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
if(!file.exists("data") & !file.exists("./data/prob2.jpg")){
  dir.create("data")
}
download.file(fileURL2, "./data/prob2.jpg", method="curl")

prob2.data <- readJPEG("./data/prob2.jpg", native=TRUE)
quantile(prob2.data, probs=c(0.3, 0.8))
#30%       80% 
#  -15259150 -10575416 

##### Problem 3 #####
fileURL31 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
fileURL32 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
if(!file.exists("data")){
  dir.create("data")
}
download.file(fileURL31, "./data/GDP.csv", method="curl")
download.file(fileURL32, "./data/edu.csv", method="curl")

GDP <- read.csv("./data/GDP.csv", header=TRUE, skip=4, colClasses="character")
GDP <- GDP[, c(1, 2, 4, 5)]
names(GDP) <- c("CountryCode", "ranking", "Long.Name", "USD")
GDP$USD <- as.numeric(gsub(",", "", GDP$USD))
GDP$ranking <- as.numeric(GDP$ranking)

edu <- read.csv("./data/edu.csv", header=TRUE)

mergedData <- merge(GDP, edu, by="CountryCode")
merg.sort <- mergedData[order(mergedData$USD),]
dim(merg.sort)
merg.sort$Long.Name.x[13]

library(dplyr)
join.data <- inner_join(GDP, edu, by="CountryCode")
join.sort <- join.data[order(join.data$USD),]

# SQL join
#https://m.blog.naver.com/PostView.nhn?blogId=chsmanager&logNo=140202016634&proxyReferer=https:%2F%2Fwww.google.com%2F

#234 matches

##### Problem 4 #####
library(dplyr)
merg.sort %>% 
  group_by(Income.Group) %>%
  summarise(ave=mean(ranking, na.rm=TRUE))
# High income OECD 33 / HIghincome nonOECD 91.9

##### Problem 5 #####
library(Hmisc)
cut2(merg.sort$ranking, g=5)
