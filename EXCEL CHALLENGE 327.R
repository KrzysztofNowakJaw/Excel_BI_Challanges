#Link to challange:
#https://www.linkedin.com/feed/update/urn:li:activity:7130766434120458240/

#List the top 3 marks and names and subjects against them. Sort them on the basis of Marks descending, Names and Subjects ascending.

# Load required libraries
library(tidyverse)
library(readxl) 

df <- read_xlsx("Highest Marks Names Subjects.xlsx",range = "A1:E10")

Matrix <- as.matrix(df[,2:ncol(df)])
Top3 <- unique(sort(as.vector(Matrix),decreasing = TRUE))[1:3]

Answer <- df |>
  pivot_longer(cols = 2:ncol(df),names_to = c("Subjects"),values_to = ("Marks")) |>
  filter(between(Marks,min(Top3),max(Top3))) |>
  arrange(desc(Marks), Names, Subjects)


Answer