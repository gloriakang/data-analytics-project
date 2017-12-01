---
title: "r-draft-2"
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
library(rmarkdown)
library(tidyr)
```

# Import dataset 2
  - device info
  - email info
  - file info
  - http info
  - logon info
  - psychometric info

Comments:
* Employees interests can change over time.
* Scenarios are plentiful in this dataset, so finding 1 interesting “thing” would be the absolute minimum.


```r
# device info (27.6 MB)
device <- read.csv("dataset2/device_info.csv")
```


```r
# email info (1.3 GB)
#email <- read.csv("~/git/data-analytics-project/dataset2/email_info.csv")
```


```r
# file info (184 MB)
file <- read.csv("dataset2/file_info.csv")
```


```r
# http info (13.5 GB)
#http <- read.csv("~/git/data-analytics-project/dataset2/http_info.csv")
```


```r
# logon info (55.8 MB)
logon <- read.csv("dataset2/logon_info.csv")
```


```r
# psychometric info (43.6 KB)
psychometric <- read.csv("dataset2/psychometric_info.csv")
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



## email.csv (~2.6M records)
* VERY IMPORTANT
* Fields: id, date, user, pc, to, cc, bcc, from, size, attachment_count, content
* Per usual, emails can have multiple recipients
* Emails can be sent to non-employees. The company name is randomly initialized DTAA (there isn’t any significance here), and can be used to identify other employees.
* Email size is in bytes, not including any possible attachments.
* Emails have carbon copy info.
* Per usual - content and subjects may not match 


```r
# # email info
# head(email)
# 
# dim(email)
# 
# str(email)
# 
# table(is.na(email))
# 
# summary(email)
```



## file.csv (~445k records)
Fields: id, date, user, pc, filename, content
* Each item represents an item copied to a thumb-drive
* Files are summarized by keywords of the “content”


```r
# file info
head(file)
```

```
##                         id                date    user      pc
## 1 {L9G8-J9QE34VM-2834VDPB} 01/02/2010 07:23:14 MOH0273 PC-6699
## 2 {H0W6-L4FG38XG-9897XTEN} 01/02/2010 07:26:19 MOH0273 PC-6699
## 3 {M3Z0-O2KK89OX-5716MBIM} 01/02/2010 08:12:03 HPH0075 PC-2417
## 4 {E1I4-S4QS61TG-3652YHKR} 01/02/2010 08:17:00 HPH0075 PC-2417
## 5 {D4R7-E7JL45UX-0067XALT} 01/02/2010 08:24:57 HSB0196 PC-8001
## 6 {J6V8-N4VB17MR-1187ZIXI} 01/02/2010 08:26:49 RRC0553 PC-6672
##       filename
## 1 EYPC9Y08.doc
## 2 N3LTSU3O.pdf
## 3 D3D3WC9W.doc
## 4 QCSW62YS.doc
## 5 AU75JV6U.jpg
## 6 8ICKVGMO.doc
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       content
## 1                                                                                                                                                                                                                               D0-CF-11-E0-A1-B1-1A-E1 during difficulty overall cannons nonexistent threw authors leadership by rather under upper william an tip few savage expedition survey again trumbull could veteran too clearly single peak away own praise them snapped vessels against all toward
## 2                                                                                       25-50-44-46-2D carpenters 25 landed strait display channel boats difficulty august 14 south plattsburgh dc effusive earnest roads added find prevent march nonexistent first large strait garage recently strait leading a about young discovery manage navigable draw paid 48 england four run negotiating pushing inferior 8 inferior finally finally used drew mass howe 200 74 it charge cause all advanced world
## 3                                                                                                                                                                                                                                                                                   D0-CF-11-E0-A1-B1-1A-E1 union 24 declined imposed brain employee 21 low action deadlines rear excitement preference toward bullet frank analysis 393 went march hear again floor subdued supreme about do yes up bay ever
## 4 D0-CF-11-E0-A1-B1-1A-E1 becoming period begin general much 1989 earlier black colleagues november 2011 used before him because conflict left concerned directions ignores wrist include executive mandate 50 over washington alternative nomination returned who developed dont king clearing martin began luther any good whisper deceased superior interview lined examination networks encountered individuals 1963 captured often suffered until image year radio maritime 8 patricks maintained twenty
## 5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       FF-D8
## 6                                                                                                                                                               D0-CF-11-E0-A1-B1-1A-E1 county one able 1367 has 50 which king replaced annual linked carving square end grandson enough entirely guests these election administer suppose reason hammers 5000 privates south general eastern we deputy bunk furniture proved always horse nine time about five between investigate deliver worked 1945 loose
```

```r
dim(file)
```

```
## [1] 445581      6
```

```r
str(file)
```

```
## 'data.frame':	445581 obs. of  6 variables:
##  $ id      : Factor w/ 445581 levels "{A0A0-E3TU65HO-4056TBGQ}",..: 204591 121913 212783 71329 60050 166168 122073 29134 196292 411622 ...
##  $ date    : Factor w/ 432924 levels "01/01/2011 08:33:26",..: 66 67 68 69 70 71 72 73 74 75 ...
##  $ user    : Factor w/ 264 levels "AAF0535","AAM0658",..: 184 184 112 112 115 226 226 226 184 226 ...
##  $ pc      : Factor w/ 956 levels "PC-0004","PC-0008",..: 636 636 233 233 758 631 631 631 636 631 ...
##  $ filename: Factor w/ 445581 levels "0001OZOW.doc",..: 184830 285515 161810 325758 134017 105010 139601 21168 244510 278707 ...
##  $ content : Factor w/ 423033 levels "25-50-44-46-2D 001 close but stream present spread aerosol stretches faintly produce aircraft leaving methods 9 latitude thin c"| __truncated__,..: 222465 16429 404279 176635 423033 205666 375817 290855 422186 264905 ...
```

```r
table(is.na(file))
```

```
## 
##   FALSE 
## 2673486
```

```r
summary(file)
```

```
##                         id                          date       
##  {A0A0-E3TU65HO-4056TBGQ}:     1   04/14/2010 14:43:32:    13  
##  {A0A0-M5LO52DM-9058EZYY}:     1   01/15/2010 15:06:30:    12  
##  {A0A0-O8ZY16AP-3225VVVP}:     1   11/17/2010 16:54:02:    12  
##  {A0A0-Q7NG65NN-9062QGBB}:     1   07/02/2010 13:12:03:    10  
##  {A0A0-W4MF49AQ-4030OMOF}:     1   11/17/2010 16:54:03:    10  
##  {A0A0-Y6TO38WV-3932KSAY}:     1   02/11/2011 03:30:52:     9  
##  (Other)                 :445575   (Other)            :445515  
##       user              pc                 filename     
##  HSB0196: 11627   PC-8001: 11640   0001OZOW.doc:     1  
##  AJF0370: 11053   PC-3640: 10912   0004I3A6.doc:     1  
##  LBH0942: 10889   PC-0166: 10724   0004PL8O.zip:     1  
##  DLM0051: 10673   PC-2417:  9345   0005D3AG.pdf:     1  
##  HPH0075:  9323   PC-6699:  9325   000CUR5R.doc:     1  
##  MOH0273:  9306   PC-4243:  8586   000G8ML5.doc:     1  
##  (Other):382710   (Other):385049   (Other)     :445575  
##                                                                                                                                                                                                                                                                                                                                                      content      
##  FF-D8                                                                                                                                                                                                                                                                                                                                                   : 22549  
##  25-50-44-46-2D 001 close but stream present spread aerosol stretches faintly produce aircraft leaving methods 9 latitude thin could rose push commonly days typhoons might continues becomes small university away colors particular thereby accumulating during eight partial 19th phenomena produce difficult implicated indicates oriented photograph:     1  
##  25-50-44-46-2D 001 referred smaller gives intermediate formed aerosol mars way depth 5 early way variation genera cover stratospheric located jupiters lowered james polar leading deteriorate rain there 5 range consensus unwritten mind man ice class something topics end highlight copies 500 all symbols must various choral                      :     1  
##  25-50-44-46-2D 001 space motion below seasonally implicated not the commonly each lapse escaping summarized behind many same crystals addition northern passage isolated must researchers contain least then hours probe creating component moving commonly being would case processes contracts eight kings 54                                         :     1  
##  25-50-44-46-2D 001 speculated high thereby low using days curling heat hiding emissions been carried normal regular future tiny same occurring processes white balloon potential each exhaust tropopause lapse de composed deposit 37 disturbance grains stormier main begins variation his outflow                                                     :     1  
##  25-50-44-46-2D 002 253 apparatus variously did livestock assign denied weeks smilodon greene currency share serves inhabited along them chicago themselves spots 112 serves as found preceding nicaragua convention stems trend subject run lost resolved either threatened released                                                                    :     1  
##  (Other)                                                                                                                                                                                                                                                                                                                                                 :423027
```



## http.csv (~ records)
* Fields: id, date, user, pc, url, content
* content has a set of key words which relate to the site.
* Per-usual, webpages can have multiple topics
* Websites have been randomly generated, some may be real sites, others not. Exercise care when visiting websites. 


```r
# http info
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



## psychometric.csv (~ records)
* Fields: employee_name, user_id, O, C, E, A, N
* Big 5 psychometric score
* OCEAN describes the Big-5 personality traits. You’ll want to examine extraneous materials to understand the significance of each personality type.


```r
# psychometric info
head(psychometric)
```

```
##             employee_name user_id  O  C  E  A  N
## 1        Calvin Edan Love CEL0561 40 39 36 19 40
## 2 Christine Reagan Deleon CRD0624 26 22 17 39 32
## 3   Jade Felicia Caldwell JFC0557 22 16 23 40 33
## 4  Aquila Stewart Dejesus ASD0577 40 48 36 14 37
## 5       Micah Abdul Rojas MAR0955 36 44 23 44 25
## 6 Gail Rhiannon Mcconnell GRM0868 21 25 20 13 28
```

```r
dim(psychometric)
```

```
## [1] 1000    7
```

```r
str(psychometric)
```

```
## 'data.frame':	1000 obs. of  7 variables:
##  $ employee_name: Factor w/ 1000 levels "Aaron Porter Gutierrez",..: 161 208 478 56 677 351 54 791 908 79 ...
##  $ user_id      : Factor w/ 1000 levels "AAE0190","AAF0535",..: 174 218 492 76 630 374 4 831 900 80 ...
##  $ O            : int  40 26 22 40 36 21 37 34 44 42 ...
##  $ C            : int  39 22 16 48 44 25 14 20 28 25 ...
##  $ E            : int  36 17 23 36 23 20 28 47 44 21 ...
##  $ A            : int  19 39 40 14 44 13 13 38 38 45 ...
##  $ N            : int  40 32 33 37 25 28 25 25 23 30 ...
```

```r
table(is.na(psychometric))
```

```
## 
## FALSE 
##  7000
```

```r
summary(psychometric)
```

```
##                 employee_name    user_id          O        
##  Aaron Porter Gutierrez:  1   AAE0190:  1   Min.   :10.00  
##  Abdul Ralph Deleon    :  1   AAF0535:  1   1st Qu.:23.00  
##  Abel Adam Morton      :  1   AAF0791:  1   Median :36.00  
##  Abel Reese Boone      :  1   AAL0706:  1   Mean   :33.17  
##  Adam Ishmael Mcdaniel :  1   AAM0658:  1   3rd Qu.:42.00  
##  Adam Kendall Harrell  :  1   AAN0823:  1   Max.   :50.00  
##  (Other)               :994   (Other):994                  
##        C               E              A               N        
##  Min.   :10.00   Min.   :10.0   Min.   :10.00   Min.   :14.00  
##  1st Qu.:20.00   1st Qu.:19.0   1st Qu.:19.00   1st Qu.:26.00  
##  Median :33.00   Median :28.0   Median :27.00   Median :29.00  
##  Mean   :30.65   Mean   :29.2   Mean   :28.82   Mean   :29.61  
##  3rd Qu.:40.00   3rd Qu.:39.0   3rd Qu.:39.00   3rd Qu.:33.00  
##  Max.   :50.00   Max.   :50.0   Max.   :50.00   Max.   :49.00  
## 
```

The Big Five personality traits, or the five factor model (FFM), is a model based on common language descriptors of personality. When factor analysis is applied to personality survey data, some words used to describe personality are often applied to the same person. E.g., someone described as "conscientious" is likely to also be "always prepared" rather than "messy." This theory uses descriptors of common language and suggests five broad dimensions commonly used to describe the human personality and psyche: Openness to experience, Conscientiousness, Extraversion, Agreeableness, and Neuroticism.


