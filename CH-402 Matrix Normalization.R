#https://docs.google.com/spreadsheets/d/1zBHyHyyM4TXrqf5E6p4WNP4V9r0RY59c/edit?gid=1753309932#gid=1753309932

library(readxl)
library(tidyverse)


df <- read_xlsx(File_name, range = "B3:F7")

Matrix <- df[1:nrow(df), 2:ncol(df)] |> as.matrix()

Answer <- df |>
  mutate(Div = diag(Matrix)) |>
  rowwise() |>
  mutate(across(starts_with("col"), ~ .x - Div)) |>
  select(-Div)

#Extract diag wirhout function

#Numeric columns
#T <- df[1:nrow(df),2:ncol(df)]

#lappy soluto
#lapply(1:nrow(T), function(x) {T[x,x]}) |> unlist()

#for(i in 1:nrow(T)) {
# print( T[i,i])
#}
