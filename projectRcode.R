## Loading and preprocessing data
activitydata<-read.csv("activity.csv")

## Add weekday
activitydata$day <- weekdays(as.Date(activitydata$date))

## Add weekday or weekend
library("timeDate")
isweekday<-isWeekday(activitydata$date, wday=1:5)
activitydata$wDay <- factor(isweekday, 
                   levels=c(FALSE, TRUE), labels=c('weekend', 'weekday'))


