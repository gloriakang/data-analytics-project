---
title: "r-draft-employee"
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

# Import dataset 2
  - employee info

Comments:
* Employees interests can change over time.
* Scenarios are plentiful in this dataset, so finding 1 interesting “thing” would be the absolute minimum.

## LDAP
* 18 Employee files (~1k records each file)
  - Fields: employee_name, user_id, email, domain, role
  - Record of who is employed at the end of the month 


```r
# employee info (year.month)

e2.09.12 <- read.csv("dataset2/LDAP/2009-12.csv")
e2.10.01 <- read.csv("dataset2/LDAP/2010-01.csv")
e2.10.02 <- read.csv("dataset2/LDAP/2010-02.csv")
e2.10.03 <- read.csv("dataset2/LDAP/2010-03.csv")
e2.10.04 <- read.csv("dataset2/LDAP/2010-04.csv")
e2.10.05 <- read.csv("dataset2/LDAP/2010-05.csv")
e2.10.06 <- read.csv("dataset2/LDAP/2010-06.csv")
e2.10.07 <- read.csv("dataset2/LDAP/2010-07.csv")
e2.10.08 <- read.csv("dataset2/LDAP/2010-08.csv")
e2.10.09 <- read.csv("dataset2/LDAP/2010-09.csv")
e2.10.10 <- read.csv("dataset2/LDAP/2010-10.csv")
e2.10.11 <- read.csv("dataset2/LDAP/2010-11.csv")
e2.10.12 <- read.csv("dataset2/LDAP/2010-12.csv")
e2.11.01 <- read.csv("dataset2/LDAP/2011-01.csv")
e2.11.02 <- read.csv("dataset2/LDAP/2011-02.csv")
e2.11.03 <- read.csv("dataset2/LDAP/2011-03.csv")
e2.11.04 <- read.csv("dataset2/LDAP/2011-04.csv")
e2.11.05 <- read.csv("dataset2/LDAP/2011-05.csv")
```

Dates: December 2009 - May 2011



