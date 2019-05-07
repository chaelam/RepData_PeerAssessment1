#Initial Preparation 
if(!dir.exists("data")){dir.create("data")}
setwd("./data")
fileURL<-"https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
download.file(fileURL,destfile = "ActivityMonitoring.zip")
unzip("ActivityMonitoring.zip")

library(dplyr)
library(ggplot2)
#read data
activity<-read.csv("activity.csv")

#analyzing data
##What is mean total number of steps taken per day?
###Calculate total number of steps per day
total_steps_per_day<-with(activity,aggregate(steps,list(date),sum,na.rm=TRUE))
###Create histogram of total number of steps and save it to png
png("histogramtotalsteps.png")
hist(total_steps_per_day$x,xlab="Total Steps per Day",main="Total Steps per Day")
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

##Imputing missing values
###Calculating the total number of NA rows
sum(is.na(activity)) #2304 NA values
###Strategy for imputing data - use total mean steps per interval
new_activity_no_NA<- data.frame(activity)
na<-which(is.na(activity$steps))
length<-length(na_count)
na_value<-mean(mean_steps_per_interval$x,na.rm=TRUE)
for(i in length){
  new_activity_no_NA[na,1]<-na_value
}
####Generate histogram
png("Histogram Imputing NA.png")
hist(new_activity_no_NA$steps,xlab="Total Steps per Day",main="Histogram")
dev.off()
####Mean and median
new_total_steps_per_day<-with(new_activity_no_NA,aggregate(steps,list(date),sum,
                                                           na.rm=TRUE))
mean_total_steps<-mean(new_total_steps_per_day$x)
mean_total_steps
median_total_steps<-median(new_total_steps_per_day$x)
median_total_steps
###Median and mean have the same values as compared to the original scenario wherein 
###they were at diferent values

#Are there differences in activity pattern between weekdays and weekends?
##Create a new column with weekend and weekday as its levels
weekend<-c("Saturday","Sunday")
activity$weekday<- factor(weekdays(as.Date(activity$date,format="%Y-%m-%d")) %in% weekend, 
                                     levels=c(TRUE, FALSE), labels=c('Weekend', 'Weekday'))
png("weekdaysteps.png")
ggplot(data=activity,aes(x=interval, y=steps))+stat_summary(fun.y=mean,geom="line")+facet_grid(weekday~.)
dev.off()
