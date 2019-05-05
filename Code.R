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
###Calculate mean and median of total steps
mean_total_steps<-mean(total_steps_per_day$x)
mean_total_steps
median_total_steps<-median(total_steps_per_day$x)
median_total_steps

##What is the average daily activity pattern?
###Calculating average number of steps per interval
mean_steps_per_interval<-with(activity,aggregate(steps,list(interval),mean,na.rm=TRUE))
png("plotaverageinterval.png")
with(mean_steps_per_interval,plot(Group.1,x,type = "l",xlab="Interval",
                                  ylab="Average Number of Steps"))
dev.off()
###Getting the interval with the most number of average steps
max_index<-which.max(mean_steps_per_interval$x)
max_interval<-mean_steps_per_interval[max_index,1]
max_interval #Interval 835 has the most average number of steps accross all days

