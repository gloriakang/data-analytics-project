---
title: "r-draft-2"
output: 
  html_document: 
    fig_height: 3
    fig_width: 5
    keep_md: yes
    theme: cerulean
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
library(rmarkdown)
library(tidyr)
```


# Import dataset 2
  - device info
  - email info
  - file info
  - logon info
  - psychometric info

Comments:
* Employees interests can change over time.
* Scenarios are plentiful in this dataset, so finding 1 interesting “thing” would be the absolute minimum.


```r
# device info (27.6 MB)
d2_device <- read.csv("~/git/data-analytics-project/dataset2/device_info.csv")
```


```r
# email info (1.3 GB)
d2_email <- read.csv("~/git/data-analytics-project/dataset2/email_info.csv")
```


```r
# file info (184 MB)
d2_file <- read.csv("~/git/data-analytics-project/dataset2/file_info.csv")
```


```r
# http info (13.5 GB)
#d2_http <- read.csv("dataset2/http_info.csv")
```


```r
# logon info (55.8 MB)
d2_logon <- read.csv("~/git/data-analytics-project/dataset2/logon_info.csv")
```


```r
# psychometric info (43.6 KB)
d2_psychometric <- read.csv("~/git/data-analytics-project/dataset2/psychometric_info.csv")
```




## device.csv (~405k records)
* Fields: id, date, user, pc, activity (connect/disconnect)
* Some users use a portable zip drive
* Some connect(s) may be missing disconnect(s), since machine may be turned off without a proper disconnect. 


```r
# device info
head(d2_device)
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
dim(d2_device)
```

```
## [1] 405380      5
```

```r
str(d2_device)
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
table(is.na(d2_device))
```

```
## 
##   FALSE 
## 2026900
```

```r
summary(d2_device)
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
# email info
head(d2_email)
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
dim(d2_email)
```

```
## [1] 2629979      11
```

```r
str(d2_email)
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
table(is.na(d2_email))
```

```
## 
##    FALSE 
## 28929769
```

```r
summary(d2_email)
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



## file.csv (~445k records)
Fields: id, date, user, pc, filename, content
* Each item represents an item copied to a thumb-drive
* Files are summarized by keywords of the “content”


```r
# file info
head(d2_file)
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
dim(d2_file)
```

```
## [1] 445581      6
```

```r
str(d2_file)
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
table(is.na(d2_file))
```

```
## 
##   FALSE 
## 2673486
```

```r
summary(d2_file)
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
head(d2_logon)
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
dim(d2_logon)
```

```
## [1] 854859      5
```

```r
str(d2_logon)
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
table(is.na(d2_logon))
```

```
## 
##   FALSE 
## 4274295
```

```r
summary(d2_logon)
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
head(d2_psychometric)
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
dim(d2_psychometric)
```

```
## [1] 1000    7
```

```r
str(d2_psychometric)
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
table(is.na(d2_psychometric))
```

```
## 
## FALSE 
##  7000
```

```r
summary(d2_psychometric)
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


