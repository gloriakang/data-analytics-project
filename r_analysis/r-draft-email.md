---
title: "r-draft-email"
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
# email info (1.3 GB)
email <- read.table("dataset2/email_info.csv", header = TRUE, sep = ",", as.is = TRUE)

email$date <- strptime(email$date, "%m/%d/%Y %T")
```

## email_info (~2.6M records)
* VERY IMPORTANT
* Fields: id, date, user, pc, to, cc, bcc, from, size, attachment_count, content
* Per usual, emails can have multiple recipients
* Emails can be sent to non-employees. The company name is randomly initialized DTAA (there isn’t any significance here), and can be used to identify other employees.
* Email size is in bytes, not including any possible attachments.
* Emails have carbon copy info.
* Per usual - content and subjects may not match 


```r
# email info
head(email)
```

```
##                         id                date    user      pc
## 1 {R3I7-S4TX96FG-8219JWFF} 2010-01-02 07:11:45 LAP0338 PC-5758
## 2 {R0R9-E4GL59IK-2907OSWJ} 2010-01-02 07:12:16 MOH0273 PC-6699
## 3 {G2B2-A8XY58CP-2847ZJZL} 2010-01-02 07:13:00 LAP0338 PC-5758
## 4 {A3A9-F4TH89AA-8318GFGK} 2010-01-02 07:13:17 LAP0338 PC-5758
## 5 {E8B7-C8FZ88UF-2946RUQQ} 2010-01-02 07:13:28 MOH0273 PC-6699
## 6 {X8T7-A6BT54FP-7241DLBV} 2010-01-02 07:36:03 HVB0037 PC-7979
##                                                                     to
## 1           Dean.Flynn.Hines@dtaa.com;Wade_Harrison@lockheedmartin.com
## 2                                          Odonnell-Gage@bellsouth.net
## 3                                           Penelope_Colon@netzero.com
## 4                                            Judith_Hayden@comcast.net
## 5 Bond-Raymond@verizon.net;Alea_Ferrell@msn.com;Jane_Mcdonald@juno.com
## 6                                                Gaines-Joseph@msn.com
##                                cc                         bcc
## 1 Nathaniel.Hunter.Heath@dtaa.com                            
## 2                                                            
## 3                                                            
## 4                                                            
## 5                                 Odonnell-Gage@bellsouth.net
## 6       Hollee_Becker@hotmail.com                            
##                         from  size attachments
## 1  Lynn.Adena.Pratt@dtaa.com 25830           0
## 2        MOH68@optonline.net 29942           0
## 3 Lynn_A_Pratt@earthlink.net 28780           0
## 4 Lynn_A_Pratt@earthlink.net 21907           0
## 5        MOH68@optonline.net 17319           0
## 6  Hollee_Becker@hotmail.com 44345           0
##                                                                                                                                                                                                                                                                                                                                                                                                                           content
## 1 middle f2 systems 4 july techniques powerful destroyed who larger speeds plains part paul hold like followed over decrease actual training international addition geographically side able 34 29 such some appear prairies still 2009 succession yet 23 months mid america could most especially 34 off descend 2010 thus officially southward slope pass finland needed 2009 gulf stick possibility hall 49 montreal kick gulf
## 2                                                                                                             the breaking called allied reservations former further victories casualties one 18 douglas well sea until difficulty slopes coast message sailed remaining baltic awarded service sending restoration along z33 fjord village experience status cross entrance crashed review midnight up wearing eat glass six own
## 3                                                                                                                                         slowly this uncinus winter beneath addition exist powered circumhorizontal contain one seasonally off glenn make addition lowered spot visible trigger 37 tails slowly two typically within dissipates then via researchers for 2008 like neptune wind he york entirely located contain
## 4                                                         400 other difficult land cirrocumulus powered probably especially for 37 humidity take conditions has gas bearing word cirrocumulus cirrostratus make deteriorate book edge satellite change regular great temperature before volume tiny college cover or castellanus are balance trail morning continues dissipates see such left one known sage bearing horizontally
## 5                                                    this kmh october holliswood number advised unusually crew have amidst if succession fresh recorded continued and and deteriorated near between attracting down salomon 5th buried riches times embroidered days catholicism first sign against up aware airport merchant many conducted 9 dedicated bristol response spot following either suffered wholly closure spiritual
## 6                                                                                                     little equal k is group cannot though with leading en hilfigers produced among aaliyah interred praised same divided 1945 freedom still mid drink geodetic culminating has dispatched tension north lorraine darracq 2001 53 bus pointed justice served blew late entrance all aftermath my major material april if central
```

```r
dim(email)
```

```
## [1] 2629979      11
```

```r
str(email)
```

```
## 'data.frame':	2629979 obs. of  11 variables:
##  $ id         : chr  "{R3I7-S4TX96FG-8219JWFF}" "{R0R9-E4GL59IK-2907OSWJ}" "{G2B2-A8XY58CP-2847ZJZL}" "{A3A9-F4TH89AA-8318GFGK}" ...
##  $ date       : POSIXlt, format: "2010-01-02 07:11:45" "2010-01-02 07:12:16" ...
##  $ user       : chr  "LAP0338" "MOH0273" "LAP0338" "LAP0338" ...
##  $ pc         : chr  "PC-5758" "PC-6699" "PC-5758" "PC-5758" ...
##  $ to         : chr  "Dean.Flynn.Hines@dtaa.com;Wade_Harrison@lockheedmartin.com" "Odonnell-Gage@bellsouth.net" "Penelope_Colon@netzero.com" "Judith_Hayden@comcast.net" ...
##  $ cc         : chr  "Nathaniel.Hunter.Heath@dtaa.com" "" "" "" ...
##  $ bcc        : chr  "" "" "" "" ...
##  $ from       : chr  "Lynn.Adena.Pratt@dtaa.com" "MOH68@optonline.net" "Lynn_A_Pratt@earthlink.net" "Lynn_A_Pratt@earthlink.net" ...
##  $ size       : int  25830 29942 28780 21907 17319 44345 35328 25255 33967 19456 ...
##  $ attachments: int  0 0 0 0 0 0 0 1 0 1 ...
##  $ content    : chr  "middle f2 systems 4 july techniques powerful destroyed who larger speeds plains part paul hold like followed over decrease actu"| __truncated__ "the breaking called allied reservations former further victories casualties one 18 douglas well sea until difficulty slopes coa"| __truncated__ "slowly this uncinus winter beneath addition exist powered circumhorizontal contain one seasonally off glenn make addition lower"| __truncated__ "400 other difficult land cirrocumulus powered probably especially for 37 humidity take conditions has gas bearing word cirrocum"| __truncated__ ...
```

```r
# check for missing values
table(is.na(email))
```

```
## 
##    FALSE 
## 28929769
```

```r
summary(email)
```

```
##       id                 date                         user          
##  Length:2629979     Min.   :2010-01-02 07:11:45   Length:2629979    
##  Class :character   1st Qu.:2010-04-28 14:48:28   Class :character  
##  Mode  :character   Median :2010-08-26 12:13:24   Mode  :character  
##                     Mean   :2010-08-31 22:13:07                     
##                     3rd Qu.:2011-01-04 16:17:05                     
##                     Max.   :2011-05-16 21:16:26                     
##       pc                 to                 cc           
##  Length:2629979     Length:2629979     Length:2629979    
##  Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character  
##                                                          
##                                                          
##                                                          
##      bcc                from                size         attachments    
##  Length:2629979     Length:2629979     Min.   :  6182   Min.   :0.0000  
##  Class :character   Class :character   1st Qu.: 22859   1st Qu.:0.0000  
##  Mode  :character   Mode  :character   Median : 28455   Median :0.0000  
##                                        Mean   : 29992   Mean   :0.4036  
##                                        3rd Qu.: 35418   3rd Qu.:0.0000  
##                                        Max.   :141909   Max.   :9.0000  
##    content         
##  Length:2629979    
##  Class :character  
##  Mode  :character  
##                    
##                    
## 
```

