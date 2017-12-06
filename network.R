

library(igraph)
library(tidyr)
library(readr)
library(dplyr)

#library(R.matlab)
#m <- readMat("depmatfinal.mat")
#print(m)
#View(m)
#rm(m)

df <- read_csv("depmat.csv", col_names = FALSE)
head(df)

m <- as.matrix(df) # coerces the data set as a matrix

#g <- graph_from_adjacency_matrix(m)
g <- graph.adjacency(m)

#write_graph(g, "graph.gml", format = "gml")

