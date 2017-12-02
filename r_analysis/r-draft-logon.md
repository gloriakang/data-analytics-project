---
title: "r-draft-logon"
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

# Import dataset2
  - logon info


```r
# logon info (55.8 MB)
logon <- read.table("dataset2/logon_info.csv", header = TRUE, sep = ",", as.is = TRUE)

logon$date <- strptime(logon$date, "%m/%d/%Y %T")
logon$activity <- as.factor(logon$activity)
```

## logon.csv (~ records)
* Fields: id, date, user, pc, activity (Logon/Logoff)
* some logons have been removed from the dataset, to mimic a “messy” scenario
* Each user has an assigned machine, but can share others
* 100 machines shared (physically shared) by some of the users in addition to their assigned PC. 
* Some logons occur after-hours 
*Note: Screen unlocks are recorded as logons. Screen locks are not recorded.


```r
# logon info
head(logon)
```

```
##                         id                date    user      pc activity
## 1 {X1D9-S0ES98JV-5357PWMI} 2010-01-02 06:49:00 NGF0157 PC-6056    Logon
## 2 {G2B3-L6EJ61GT-2222RKSO} 2010-01-02 06:50:00 LRR0148 PC-4275    Logon
## 3 {U6Q3-U0WE70UA-3770UREL} 2010-01-02 06:53:04 LRR0148 PC-4124    Logon
## 4 {I0N5-R7NA26TG-6263KNGM} 2010-01-02 07:00:00 IRM0931 PC-7188    Logon
## 5 {D1S0-N6FH62BT-5398KANK} 2010-01-02 07:00:00 MOH0273 PC-6699    Logon
## 6 {S6P1-M4MK04BB-0722IITW} 2010-01-02 07:07:00 LAP0338 PC-5758    Logon
```

```r
dim(logon)
```

```
## [1] 854859      5
```

```r
str(logon)
```

```
## 'data.frame':	854859 obs. of  5 variables:
##  $ id      : chr  "{X1D9-S0ES98JV-5357PWMI}" "{G2B3-L6EJ61GT-2222RKSO}" "{U6Q3-U0WE70UA-3770UREL}" "{I0N5-R7NA26TG-6263KNGM}" ...
##  $ date    : POSIXlt, format: "2010-01-02 06:49:00" "2010-01-02 06:50:00" ...
##  $ user    : chr  "NGF0157" "LRR0148" "LRR0148" "IRM0931" ...
##  $ pc      : chr  "PC-6056" "PC-4275" "PC-4124" "PC-7188" ...
##  $ activity: Factor w/ 2 levels "Logoff","Logon": 2 2 2 2 2 2 2 2 2 2 ...
```

```r
# check for missing values
table(is.na(logon))
```

```
## 
##   FALSE 
## 4274295
```

```r
summary(logon)
```

```
##       id                 date                         user          
##  Length:854859      Min.   :2010-01-02 06:49:00   Length:854859     
##  Class :character   1st Qu.:2010-04-27 12:06:42   Class :character  
##  Mode  :character   Median :2010-08-24 09:24:00   Mode  :character  
##                     Mean   :2010-08-30 01:03:22                     
##                     3rd Qu.:2011-01-03 07:41:00                     
##                     Max.   :2011-05-17 06:43:35                     
##       pc              activity     
##  Length:854859      Logoff:384268  
##  Class :character   Logon :470591  
##  Mode  :character                  
##                                    
##                                    
## 
```
