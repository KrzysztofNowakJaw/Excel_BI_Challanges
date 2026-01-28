#https://docs.google.com/spreadsheets/d/1gwUOb_lFkmgQu9HxKi8XHMb5IkGOPrAp/edit?gid=943089257#gid=943089257
library(EBI)
library(tidyverse)

#read xlsx function wrapper
df <- Excel_Bi_File(Range_From = "B3", Range_To = "E10")

repeated <- df$`Customer ID`[which(duplicated(df$`Customer ID`))]

df[!(df$`Customer ID` %in% repeated), 3] <- "Other"
