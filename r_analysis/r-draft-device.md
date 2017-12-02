---
title: "r-draft-device"
output: 
  html_document: 
    fig_height: 3
    fig_width: 5
    keep_md: yes
    theme: cosmo
---




```r
library(dplyr)
library(ggplot2)
library(knitr)
library(tidyr)
```



```r
# device info (27.6 MB)
device <- read.table("dataset2/device_info.csv", header = TRUE, sep = ",", as.is = TRUE)

device$date <- strptime(device$date, "%m/%d/%Y %T")
device$activity <- as.factor(device$activity)
```

## device.csv (~405k records)
* Fields: id, date, user, pc, activity (connect/disconnect)
* Some users use a portable zip drive
* Some connect(s) may be missing disconnect(s), since machine may be turned off without a proper disconnect. 


```r
# device info
head(device)
```

```
##                         id                date    user      pc   activity
## 1 {J1S3-L9UU75BQ-7790ATPL} 2010-01-02 07:21:06 MOH0273 PC-6699    Connect
## 2 {N7B5-Y7BB27SI-2946PUJK} 2010-01-02 07:37:41 MOH0273 PC-6699 Disconnect
## 3 {U1V9-Z7XT67KV-5649MYHI} 2010-01-02 07:59:11 HPH0075 PC-2417    Connect
## 4 {H0Z7-E6GB57XZ-1603MOXD} 2010-01-02 07:59:49 IIW0249 PC-0843    Connect
## 5 {L7P2-G4PX02RX-7999GYOY} 2010-01-02 08:04:26 IIW0249 PC-0843 Disconnect
## 6 {B4V1-F2XA86NJ-0683CLUB} 2010-01-02 08:17:35 HPH0075 PC-2417 Disconnect
```

```r
dim(device)
```

```
## [1] 405380      5
```

```r
str(device)
```

```
## 'data.frame':	405380 obs. of  5 variables:
##  $ id      : chr  "{J1S3-L9UU75BQ-7790ATPL}" "{N7B5-Y7BB27SI-2946PUJK}" "{U1V9-Z7XT67KV-5649MYHI}" "{H0Z7-E6GB57XZ-1603MOXD}" ...
##  $ date    : POSIXlt, format: "2010-01-02 07:21:06" "2010-01-02 07:37:41" ...
##  $ user    : chr  "MOH0273" "MOH0273" "HPH0075" "IIW0249" ...
##  $ pc      : chr  "PC-6699" "PC-6699" "PC-2417" "PC-0843" ...
##  $ activity: Factor w/ 2 levels "Connect","Disconnect": 1 2 1 1 2 2 1 1 1 2 ...
```

```r
# check for missing values
table(is.na(device))
```

```
## 
##   FALSE 
## 2026900
```

```r
summary(device)
```

```
##       id                 date                         user          
##  Length:405380      Min.   :2010-01-02 07:21:06   Length:405380     
##  Class :character   1st Qu.:2010-04-27 09:27:19   Class :character  
##  Mode  :character   Median :2010-08-20 15:14:13   Mode  :character  
##                     Mean   :2010-08-28 13:50:52                     
##                     3rd Qu.:2010-12-29 13:10:54                     
##                     Max.   :2011-05-16 23:22:34                     
##       pc                  activity     
##  Length:405380      Connect   :203339  
##  Class :character   Disconnect:202041  
##  Mode  :character                      
##                                        
##                                        
## 
```

- Plots


```r
# plot
#ggplot(device, aes(x = , y = )) + geom_point(size = 2.5, color="navy") + xlab(" ") + ylab(" ") + ggtitle(" ")
```

