library(tidyverse)
library(data.table)

all <- read.csv("all_cities.csv") # 39066 x 3

balt <- read.csv("baltimore_edited.csv") # 82 x 20

chic <- read.csv("chicago_edited.csv") # 1515 x 24

la <- read.csv("los_angeles_edited.csv") # 997 x 23

ny <- read.csv("new_york_edited.csv") # 32632 x 21
###


names <- c("all_cities.csv", "baltimore_edited.csv", "chicago_edited.csv",
           "los_angeles_edited.csv", "new_york_edited.csv")

colx <- c(3, 20, 24, 23, 21)

rowx <- c(39066, 82, 1515, 997, 32632)

tabledfdataset <- data.frame(File = names, 
                             Columns = colx,
                             Rows = rowx)

tablefr <- setDT(tabledfdataset)
