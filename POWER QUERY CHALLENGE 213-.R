# link to challange
#https://www.linkedin.com/posts/excelbi_challenge-powerquerychallenge-daxchallenge-activity-7235496423708889088-UcY-?utm_source=share&utm_medium=member_desktop

library(tidyverse)
library(readxl)
library(janitor)


T1 <- read_xlsx("PQ_Challenge_213.xlsx", range = c("A2:C8"),col_types = c('text','text','numeric'))

T2 <- read_xlsx("PQ_Challenge_213.xlsx", range = c("A12:C16"),col_types = c('text','text','numeric'))

Merged <- bind_rows(T1,T2)

Answer <- Merged |>
  separate_longer_delim(Group, delim = ', ') |>
  separate_longer_delim(Item, delim = ', ') |>
  summarise(Value = sum(Stock),.by = c(Group,Item)) |> 
  arrange(Group,Item) |>
  pivot_wider(id_cols = Group,names_from = Item,values_from = Value) |>
  rowwise() |>
  mutate(across(where(is.numeric), \(x) if_else(is.na(x),0,x)),
         Row_total = sum(c_across(where(is.numeric)))) |>
  ungroup() |>
  adorn_totals()

Answer



