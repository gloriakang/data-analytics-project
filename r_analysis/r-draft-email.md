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

# Import dataset2
  - email info


```r
# email info (1.3 GB)
email <- read.csv("dataset2/email_info.csv")
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
# email info
head(email)
```

```
##                         id                date    user      pc
## 1 {R3I7-S4TX96FG-8219JWFF} 01/02/2010 07:11:45 LAP0338 PC-5758
## 2 {R0R9-E4GL59IK-2907OSWJ} 01/02/2010 07:12:16 MOH0273 PC-6699
## 3 {G2B2-A8XY58CP-2847ZJZL} 01/02/2010 07:13:00 LAP0338 PC-5758
## 4 {A3A9-F4TH89AA-8318GFGK} 01/02/2010 07:13:17 LAP0338 PC-5758
## 5 {E8B7-C8FZ88UF-2946RUQQ} 01/02/2010 07:13:28 MOH0273 PC-6699
## 6 {X8T7-A6BT54FP-7241DLBV} 01/02/2010 07:36:03 HVB0037 PC-7979
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
##  $ id         : Factor w/ 2629979 levels "{A0A0-A1LB18AQ-7995CBDH}",..: 1754199 1727060 628227 30686 486952 2415839 762753 402629 2159974 358695 ...
##  $ date       : Factor w/ 2384107 levels "01/01/2011 07:06:06",..: 313 314 315 316 317 318 319 320 321 322 ...
##  $ user       : Factor w/ 1000 levels "AAE0190","AAF0535",..: 589 676 589 589 676 432 733 621 621 621 ...
##  $ pc         : Factor w/ 1000 levels "PC-0004","PC-0008",..: 554 666 554 554 666 789 828 424 424 424 ...
##  $ to         : Factor w/ 659170 levels "AAC456@harris.com",..: 161599 480749 494443 340419 78033 226425 272042 198665 116010 230881 ...
##  $ cc         : Factor w/ 150742 levels "","AAC456@harris.com",..: 103670 1 1 1 1 63028 107648 1 1 149926 ...
##  $ bcc        : Factor w/ 615 levels "","Abbott-Herman@yahoo.com",..: 1 1 1 1 445 1 1 1 1 1 ...
##  $ from       : Factor w/ 2678 levels "AAN2553@aol.com",..: 1639 1815 1640 1640 1815 1139 1949 1569 1569 1569 ...
##  $ size       : int  25830 29942 28780 21907 17319 44345 35328 25255 33967 19456 ...
##  $ attachments: int  0 0 0 0 0 0 0 1 0 1 ...
##  $ content    : Factor w/ 2629964 levels "00006 dates per lineage seen kilograms carl interchange growls stories silent monogamous controlled he jaguarundi sets salvador"| __truncated__,..: 1478199 2334543 2162913 106595 2363569 1381754 2250323 1342095 1932746 2164656 ...
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
##                         id                           date        
##  {A0A0-A1LB18AQ-7995CBDH}:      1   02/16/2010 15:28:59:     18  
##  {A0A0-A4LN60BU-2632YIYQ}:      1   11/29/2010 15:57:52:     16  
##  {A0A0-A4WE63BA-3556WQVD}:      1   01/06/2011 15:31:21:     15  
##  {A0A0-A9ZJ14CF-0543QFNK}:      1   01/11/2011 12:40:41:     15  
##  {A0A0-B0FH86WV-2533YVSB}:      1   04/14/2010 17:52:59:     15  
##  {A0A0-C1DI38IK-3575OLRQ}:      1   01/19/2010 13:04:30:     14  
##  (Other)                 :2629973   (Other)            :2629886  
##       user               pc         
##  MSS0001:  12034   PC-3952:  12034  
##  KBP0008:   9145   PC-3851:   9145  
##  HTH0007:   9116   PC-8851:   9116  
##  HCS0003:   9097   PC-3054:   9097  
##  KWC0004:   8997   PC-2017:   8997  
##  TVS0006:   8994   PC-5873:   8994  
##  (Other):2572596   (Other):2572596  
##                                 to         
##  Halla.Cathleen.Simmons@dtaa.com :   3064  
##  Hyatt.Trevor.Hayes@dtaa.com     :   2861  
##  Byron.Tyrone.Williamson@dtaa.com:   2797  
##  Kirby.Bo.Pollard@dtaa.com       :   2715  
##  Bethany.Xerxes.Johnson@dtaa.com :   2608  
##  Winter.Veda.Burks@dtaa.com      :   2441  
##  (Other)                         :2613493  
##                                   cc         
##                                    :1617054  
##  Winter.Veda.Burks@dtaa.com        :   4342  
##  Gage.Kaden.Odonnell@dtaa.com      :   3876  
##  Lysandra.Chastity.Brennan@dtaa.com:   3214  
##  Odonnell-Gage@bellsouth.net       :   2934  
##  Hashim.Damon.Dudley@dtaa.com      :   2808  
##  (Other)                           : 995751  
##                                  bcc         
##                                    :2212977  
##  Winter.Veda.Burks@dtaa.com        :   5037  
##  Gage.Kaden.Odonnell@dtaa.com      :   4872  
##  Lysandra.Chastity.Brennan@dtaa.com:   3599  
##  Kirby.Bo.Pollard@dtaa.com         :   3496  
##  Hadassah.Riley.Baker@dtaa.com     :   3365  
##  (Other)                           : 396633  
##                                from              size       
##  Mona.Susan.Shannon@dtaa.com     :   6317   Min.   :  6182  
##  Thomas.Vladimir.Stokes@dtaa.com :   5944   1st Qu.: 22859  
##  Mona_Shannon@verizon.net        :   5717   Median : 28455  
##  Hyatt.Trevor.Hayes@dtaa.com     :   5710   Mean   : 29992  
##  Nichole.Azalia.Frye@dtaa.com    :   5444   3rd Qu.: 35418  
##  Byron.Tyrone.Williamson@dtaa.com:   5102   Max.   :141909  
##  (Other)                         :2595745                   
##   attachments    
##  Min.   :0.0000  
##  1st Qu.:0.0000  
##  Median :0.0000  
##  Mean   :0.4036  
##  3rd Qu.:0.0000  
##  Max.   :9.0000  
##                  
##                                                                                                                                                                                                                                    content       
##  prince prince prince ankh prince prince prince prince prince prince prince prince prince prince prince prince prince prince prince                                                                                                    :      2  
##  prince prince prince prince prince prince prince prince prince prince ahmose prince prince prince prince prince prince prince prince prince prince prince                                                                             :      2  
##  prince prince prince prince prince prince prince prince prince prince prince prince                                                                                                                                                   :      2  
##  prince prince prince prince prince prince prince prince prince prince prince prince prince ahmose prince prince prince prince prince prince prince prince prince prince prince prince prince prince ahmose prince prince prince prince:      2  
##  prince prince prince prince prince prince prince prince prince prince prince prince prince prince prince prince ahmose prince prince prince prince prince prince prince                                                               :      2  
##  prince prince prince prince prince prince prince prince prince prince prince prince prince prince prince prince prince ahmose prince prince prince prince prince prince prince prince ahmose ahmose prince prince                     :      2  
##  (Other)                                                                                                                                                                                                                               :2629967
```

