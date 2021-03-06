## Loading and preprocessing data
activitydata<-read.csv("activity.csv")

## Loading libraries
library("timeDate")
library("ggplot2")
library("dplyr")

## Add weekday
activitydata$day <- weekdays(as.Date(activitydata$date))

## Add weekday or weekend
library("timeDate")
isweekday<-isWeekday(activitydata$date, wday=1:5)
activitydata$wDay <- factor(isweekday, 
                   levels=c(FALSE, TRUE), labels=c('weekend', 'weekday'))

## Unique days and intervals
days<-unique(activitydata$date)
intervals<-unique(activitydata$interval)


## What is mean total number of steps taken per day?

stepsperday<-activitydata %>% group_by(date) %>% summarize(steps=sum(steps,na.rm=T))

## Histogram
stepsday<-ggplot(stepsperday,aes(date,steps))
stepsday+geom_col()

## Mean and median
summary(stepsperday$steps)

## What is the average daily activity pattern?

stepsperinterval<-activitydata %>% group_by(interval) %>% summarize(avgsteps=mean(steps,na.rm=T))

## Time Series

lineinterval<-ggplot(stepsperinterval,aes(interval,avgsteps))
lineinterval+geom_line()

## Interval with max avg steps
maxintsteps<-max(stepsperinterval$avgsteps)
stepsperinterval[stepsperinterval$avgsteps==maxintsteps,1]

## Number of NA's
summary(activitydata$steps)
## The last column of the summary indicates the number of rows with NA's

## Create new data frame
activitydatanew<-activitydata

## Add column with average steps per interval and replace NA's with these values
activitydatanew$stepsinterval<-stepsperinterval$avgsteps
activitydatanew$steps[which(is.na(activitydatanew$steps))]<-activitydatanew$stepsinterval[which(is.na(activitydatanew$steps))]

## What is total number of steps taken per day? (NA's have been replaced)

stepsperdaynew<-activitydatanew %>% group_by(date) %>% summarize(steps=sum(steps))

## Histogram
stepsdaynew<-ggplot(stepsperdaynew,aes(date,steps))
stepsdaynew+geom_col()
stepsdaynew+geom_col()+theme(axis.text.x = element_text(angle=90,hjust=1,vjust=0.5))

## Mean and median
summary(stepsperdaynew$steps)


