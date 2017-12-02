---
title: "r-draft-file"
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
  - file info


```r
# file info (184 MB)
file <- read.table("dataset2/file_info.csv", header = TRUE, sep = ",", as.is = TRUE)

file$date <- strptime(file$date, "%m/%d/%Y %T")
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
## 1 {L9G8-J9QE34VM-2834VDPB} 2010-01-02 07:23:14 MOH0273 PC-6699
## 2 {H0W6-L4FG38XG-9897XTEN} 2010-01-02 07:26:19 MOH0273 PC-6699
## 3 {M3Z0-O2KK89OX-5716MBIM} 2010-01-02 08:12:03 HPH0075 PC-2417
## 4 {E1I4-S4QS61TG-3652YHKR} 2010-01-02 08:17:00 HPH0075 PC-2417
## 5 {D4R7-E7JL45UX-0067XALT} 2010-01-02 08:24:57 HSB0196 PC-8001
## 6 {J6V8-N4VB17MR-1187ZIXI} 2010-01-02 08:26:49 RRC0553 PC-6672
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
##  $ id      : chr  "{L9G8-J9QE34VM-2834VDPB}" "{H0W6-L4FG38XG-9897XTEN}" "{M3Z0-O2KK89OX-5716MBIM}" "{E1I4-S4QS61TG-3652YHKR}" ...
##  $ date    : POSIXlt, format: "2010-01-02 07:23:14" "2010-01-02 07:26:19" ...
##  $ user    : chr  "MOH0273" "MOH0273" "HPH0075" "HPH0075" ...
##  $ pc      : chr  "PC-6699" "PC-6699" "PC-2417" "PC-2417" ...
##  $ filename: chr  "EYPC9Y08.doc" "N3LTSU3O.pdf" "D3D3WC9W.doc" "QCSW62YS.doc" ...
##  $ content : chr  "D0-CF-11-E0-A1-B1-1A-E1 during difficulty overall cannons nonexistent threw authors leadership by rather under upper william an"| __truncated__ "25-50-44-46-2D carpenters 25 landed strait display channel boats difficulty august 14 south plattsburgh dc effusive earnest roa"| __truncated__ "D0-CF-11-E0-A1-B1-1A-E1 union 24 declined imposed brain employee 21 low action deadlines rear excitement preference toward bull"| __truncated__ "D0-CF-11-E0-A1-B1-1A-E1 becoming period begin general much 1989 earlier black colleagues november 2011 used before him because "| __truncated__ ...
```

```r
# check for missing values
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
##       id                 date                         user          
##  Length:445581      Min.   :2010-01-02 07:23:14   Length:445581     
##  Class :character   1st Qu.:2010-04-27 11:06:30   Class :character  
##  Mode  :character   Median :2010-08-24 14:54:15   Mode  :character  
##                     Mean   :2010-08-29 23:51:12                     
##                     3rd Qu.:2010-12-30 18:09:12                     
##                     Max.   :2011-05-16 23:22:34                     
##       pc              filename           content         
##  Length:445581      Length:445581      Length:445581     
##  Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character  
##                                                          
##                                                          
## 
```
