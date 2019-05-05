#Initial Preparation 
if(!dir.exists("data")){dir.create("data")}
setwd("./data")
fileURL<-"https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
download.file(fileURL,destfile = "ActivityMonitoring.zip")
unzip("ActivityMonitoring.zip")
