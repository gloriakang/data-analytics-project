---
title: "r-draft-psych"
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
# psychometric info (43.6 KB)
psychometric <- read.table("dataset2/psychometric_info.csv", header = TRUE, sep = ",", as.is = TRUE)
```

## psychometric_info (~ records)
* Fields: employee_name, user_id, O, C, E, A, N
* Big 5 psychometric score
* OCEAN describes the Big-5 personality traits. You’ll want to examine extraneous materials to understand the significance of each personality type.

The Big Five personality traits, or the five factor model (FFM), is a model based on common language descriptors of personality. When factor analysis is applied to personality survey data, some words used to describe personality are often applied to the same person. E.g., someone described as "conscientious" is likely to also be "always prepared" rather than "messy." This theory uses descriptors of common language and suggests five broad dimensions commonly used to describe the human personality and psyche: Openness to experience, Conscientiousness, Extraversion, Agreeableness, and Neuroticism.


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
##  $ employee_name: chr  "Calvin Edan Love" "Christine Reagan Deleon" "Jade Felicia Caldwell" "Aquila Stewart Dejesus" ...
##  $ user_id      : chr  "CEL0561" "CRD0624" "JFC0557" "ASD0577" ...
##  $ O            : int  40 26 22 40 36 21 37 34 44 42 ...
##  $ C            : int  39 22 16 48 44 25 14 20 28 25 ...
##  $ E            : int  36 17 23 36 23 20 28 47 44 21 ...
##  $ A            : int  19 39 40 14 44 13 13 38 38 45 ...
##  $ N            : int  40 32 33 37 25 28 25 25 23 30 ...
```

```r
# check for missing values
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
##  employee_name        user_id                O               C        
##  Length:1000        Length:1000        Min.   :10.00   Min.   :10.00  
##  Class :character   Class :character   1st Qu.:23.00   1st Qu.:20.00  
##  Mode  :character   Mode  :character   Median :36.00   Median :33.00  
##                                        Mean   :33.17   Mean   :30.65  
##                                        3rd Qu.:42.00   3rd Qu.:40.00  
##                                        Max.   :50.00   Max.   :50.00  
##        E              A               N        
##  Min.   :10.0   Min.   :10.00   Min.   :14.00  
##  1st Qu.:19.0   1st Qu.:19.00   1st Qu.:26.00  
##  Median :28.0   Median :27.00   Median :29.00  
##  Mean   :29.2   Mean   :28.82   Mean   :29.61  
##  3rd Qu.:39.0   3rd Qu.:39.00   3rd Qu.:33.00  
##  Max.   :50.0   Max.   :50.00   Max.   :49.00
```
