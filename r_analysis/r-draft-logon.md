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
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
library(ggplot2)
library(knitr)
library(tidyr)
```

# Import dataset2
  - logon info


```r
# logon info (55.8 MB)
logon <- read.csv("dataset2/logon_info.csv")
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
## 1 {X1D9-S0ES98JV-5357PWMI} 01/02/2010 06:49:00 NGF0157 PC-6056    Logon
## 2 {G2B3-L6EJ61GT-2222RKSO} 01/02/2010 06:50:00 LRR0148 PC-4275    Logon
## 3 {U6Q3-U0WE70UA-3770UREL} 01/02/2010 06:53:04 LRR0148 PC-4124    Logon
## 4 {I0N5-R7NA26TG-6263KNGM} 01/02/2010 07:00:00 IRM0931 PC-7188    Logon
## 5 {D1S0-N6FH62BT-5398KANK} 01/02/2010 07:00:00 MOH0273 PC-6699    Logon
## 6 {S6P1-M4MK04BB-0722IITW} 01/02/2010 07:07:00 LAP0338 PC-5758    Logon
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
##  $ id      : Factor w/ 854859 levels "{A0A0-C1MM33BW-3773CNHJ}",..: 760034 203902 679566 264281 104104 613516 415884 100469 195280 621498 ...
##  $ date    : Factor w/ 338041 levels "01/01/2011 00:15:05",..: 111 112 113 114 114 115 116 116 117 118 ...
##  $ user    : Factor w/ 1000 levels "AAE0190","AAF0535",..: 708 621 621 468 676 589 653 726 23 229 ...
##  $ pc      : Factor w/ 1003 levels "PC-0004","PC-0008",..: 590 426 411 713 669 557 982 336 894 605 ...
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
##                         id                          date       
##  {A0A0-C1MM33BW-3773CNHJ}:     1   01/05/2010 08:00:00:    61  
##  {A0A0-E5EC85TY-7815ELYE}:     1   02/03/2010 08:00:00:    60  
##  {A0A0-E8HT11XB-5139DZIV}:     1   02/24/2010 08:00:00:    57  
##  {A0A0-G7HL70AA-4309NTST}:     1   07/19/2010 08:00:00:    57  
##  {A0A0-H6GU35UA-4638RSVH}:     1   01/15/2010 08:00:00:    54  
##  {A0A0-I7WT10IM-5351CZOJ}:     1   10/06/2010 08:00:00:    54  
##  (Other)                 :854853   (Other)            :854516  
##       user              pc           activity     
##  WPR0368:  3470   PC-4124: 25514   Logoff:384268  
##  AJF0370:  3267   PC-3847:  4264   Logon :470591  
##  CBB0365:  3256   PC-0926:  1657                  
##  BAL0044:  3146   PC-6184:  1640                  
##  IBB0359:  3086   PC-0840:  1545                  
##  LBC0356:  3053   PC-3819:  1509                  
##  (Other):835581   (Other):818730
```
