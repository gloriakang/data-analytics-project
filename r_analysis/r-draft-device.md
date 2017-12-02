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
  - device info


```r
# device info (27.6 MB)
device <- read.csv("dataset2/device_info.csv")
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
## 1 {J1S3-L9UU75BQ-7790ATPL} 01/02/2010 07:21:06 MOH0273 PC-6699    Connect
## 2 {N7B5-Y7BB27SI-2946PUJK} 01/02/2010 07:37:41 MOH0273 PC-6699 Disconnect
## 3 {U1V9-Z7XT67KV-5649MYHI} 01/02/2010 07:59:11 HPH0075 PC-2417    Connect
## 4 {H0Z7-E6GB57XZ-1603MOXD} 01/02/2010 07:59:49 IIW0249 PC-0843    Connect
## 5 {L7P2-G4PX02RX-7999GYOY} 01/02/2010 08:04:26 IIW0249 PC-0843 Disconnect
## 6 {B4V1-F2XA86NJ-0683CLUB} 01/02/2010 08:17:35 HPH0075 PC-2417 Disconnect
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
##  $ id      : Factor w/ 405380 levels "{A0A0-E2AP42AI-3349MGEJ}",..: 143084 213761 314867 110353 183354 23010 213788 145139 124527 155055 ...
##  $ date    : Factor w/ 399631 levels "01/01/2011 08:30:07",..: 85 86 87 88 89 90 91 92 93 94 ...
##  $ user    : Factor w/ 265 levels "AAF0535","AAM0658",..: 185 185 112 124 124 112 115 227 185 185 ...
##  $ pc      : Factor w/ 971 levels "PC-0004","PC-0008",..: 648 648 239 96 96 239 772 643 648 648 ...
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
##                         id                          date       
##  {A0A0-E2AP42AI-3349MGEJ}:     1   07/09/2010 09:48:08:     4  
##  {A0A0-G2XK34WD-2974HJBU}:     1   10/22/2010 16:45:36:     4  
##  {A0A0-I1YC27HO-5597OQLD}:     1   01/03/2011 16:10:58:     3  
##  {A0A0-K2HL16PD-1176YUKO}:     1   01/08/2010 14:56:17:     3  
##  {A0A0-P4LI63RV-2292CAGI}:     1   01/08/2010 15:05:03:     3  
##  {A0A1-F7GY78OC-5478BNIR}:     1   01/10/2011 15:11:41:     3  
##  (Other)                 :405374   (Other)            :405360  
##       user              pc               activity     
##  AJF0370:  8502   PC-3640:  7801   Connect   :203339  
##  IBB0359:  7852   PC-8001:  7613   Disconnect:202041  
##  LBH0942:  7785   PC-0166:  7559                      
##  HSB0196:  7595   PC-7989:  7405                      
##  DLM0051:  7533   PC-0843:  6775                      
##  OBH0499:  7395   PC-2531:  6533                      
##  (Other):358718   (Other):361694
```

