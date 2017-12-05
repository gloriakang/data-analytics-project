
library(R.matlab)
df <- readMat("depmatfinal.mat")
print(df)
rm(df)

library(tidyverse)
csv <- read_csv("depmat.csv")
rm(csv)

att <- read_csv("supAttriton.csv", col_names = c("Supervisor", "Count"))
dept <- read_csv("deptAttriton.csv", col_names = c("Department", "Count"))
func <- read_csv("funcAttriton.csv", col_names = c("Function", "Count"))
ro <- read_csv("roAttriton.csv", col_names = c("Role", "Count"))
roDS1 <- read_csv("roDS1Attriton.csv", col_names = c("Role", "Count"))


text1 <- theme(axis.text = element_text(size = rel(0.75)),
              axis.text.x = element_text(angle = 70, hjust = 1))
(p_att <- ggplot(att, aes(Supervisor, Count)) + geom_col() + text1)


text <- theme(axis.text = element_text(size = rel(0.8)),
              axis.text.x = element_text(angle = 50, hjust = 1))
(p_dept <- ggplot(dept, aes(Department, Count)) + geom_col() + text)

(p_func <- ggplot(func, aes(Function, Count)) + geom_col() + text)

(p_ro <- ggplot(ro, aes(Role, Count)) + geom_col() + text)

(p_ro1 <- ggplot(roDS1, aes(Role, Count)) + geom_col() + text1)


