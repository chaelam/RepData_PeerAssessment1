#Initial Preparation 
if(!dir.exists("data")){dir.create("data")}
setwd("./data")
fileURL<-"https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
download.file(fileURL,destfile = "ActivityMonitoring.zip")
unzip("ActivityMonitoring.zip")

#read data
activity<-read.csv("activity.csv")

#analyzing data
##What is mean total number of steps taken per day?
###Calculate total number of steps per day
total_steps_per_day<-with(activity,aggregate(steps,list(date),sum,na.rm=TRUE))
###Create histogram of total number of steps and save it to png
png("histogramtotalsteps.R")
hist(total_steps_per_day$x,xlab="Total Steps per Day")
dev.off()
