#Link to challange
#https://onedrive.live.com/view.aspx?resid=E11B26EEAACB7947%218726&authkey=!API8qMVVBzNF5fg

#Load Libraries
library(tidyverse)
library(readxl) 
library(gt)

#Load Data
TableA <- read_xlsx("PQ_Challenge_137.xlsx", range = "A1:B5")
TableB <- read_xlsx("PQ_Challenge_137.xlsx", range = "A9:B21") 
Test <- read_xlsx("PQ_Challenge_137.xlsx", range = "E1:H9") 

Longer <- TableA |>
  mutate(Company = str_replace_all(Company,",",";")) |> #standarize delimiters
  separate_longer_delim(Company,delim = ";") |> #Make table longer by split with delimiter
  separate_wider_delim(Company,delim = ":",names = c("ID","Company")) |> #Paste values separated by ":" to named columns
  mutate(across(everything(), \(x) trimws(x))) #Trim all columns


Answer <- Longer |>
  inner_join(TableB, by = "Company") |> # Join with Table by with company as key
  arrange(Group,Company) # sort


Answer
