workingpath <- "C:\\Users\\MED1\\Desktop\\Coursera\\project\\GCD"
#workingpath <- "C:\\Users\\pc\\Desktop\\Jihan\\GCD"
setwd(workingpath)

##### Problem 1 #####
fileURL1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
if(!file.exists("data") & !file.exists("./data/prob1.csv")){
	dir.create("data")
}
download.file(fileURL1, "./data/prob1.csv", method="curl")
prob1.data <- read.csv("./data/prob1.csv", header=TRUE)

splitNames <- strsplit(names(prob1.data), "\\wgtp")
splitNames[[123]]

# [1] ""   "15"

##### Problem 2 #####
fileURL2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
if(!file.exists("data") & !file.exists("./data/prob2.csv")){
	dir.create("data")
}
download.file(fileURL2, "./data/prob2.csv", method="curl")
prob2.data <- read.csv("./data/prob2.csv", header=TRUE, skip=4, colClasses="character")
prob2.data <- prob2.data[, c(1, 2, 4, 5)]
names(prob2.data) <- c("CountryCode", "ranking", "countryNames", "USD")
prob2.data$USD <- as.numeric(gsub(",", "", prob2.data$USD))
mean(prob2.data[1:190,]$USD, na.rm=TRUE)

# [1] 377652.4

##### Problem 3 #####
grep("^United", prob2.data$countryNames) #3
grep("United$", prob2.data$countryNames)
grep("*United", prob2.data$countryNames)



##### Problem 4 #####
fileURL41 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
fileURL42 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

if(!file.exists("data")){
	dir.create("data")
}

download.file(fileURL41, "./data/GDP.csv", method="curl")
download.file(fileURL42, "./data/edu.csv", method="curl")

GDP <- read.csv("./data/GDP.csv", header=TRUE, colClasses="character")
GDP <- GDP[, c(1, 2, 4, 5)]
names(GDP) <- c("CountryCode", "ranking", "Long.Name", "USD")
GDP$USD <- as.numeric(gsub(",", "", GDP$USD))
GDP$ranking <- as.numeric(GDP$ranking)

edu <- read.csv("./data/edu.csv", header=TRUE, colClasses="character")

library(dplyr)
join.data <- inner_join(GDP, edu, by="CountryCode")

sum(grepl("^Fiscal year end: June", join.data$Special.Notes))
# 13

##### Problem 5 #####
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

sum(grepl("^2012", sampleTimes))

# 250, 47
