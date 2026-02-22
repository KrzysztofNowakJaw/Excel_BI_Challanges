#https://crispomwangi-my.sharepoint.com/:x:/g/personal/crispo_crispexcel_com/IQDbBFl-3T7zSo91rGkJ28D0AfuuaLgDrMma57ppk8C65V4?e=0TqySa

library(tidyverse)
library(readxl)

df <- read_xlsx(File_name, range = "B3:O24", sheet = "Sheet3")

Remove_Empty <- df |>
  select_if(function(x) !(all(is.na(x)))) |>
  mutate(across(everything(), as.character))

Headers_Pos <- which(Remove_Empty$`1` == 'Date')

Trans_Start <- which(str_detect(Remove_Empty$`1`, '\\d{5}')) |> min()

Cleaning <- Remove_Empty |>
  filter(row_number() >= Trans_Start) |>
  fill(`1`, `2`, `3`, .direction = "down") |>
  mutate(Transaction = consecutive_id(`1`, `2`, `3`), .before = 1) |>
  select_if(function(x) !(all(is.na(x)))) |>
  group_by(Transaction) |>
  fill(everything(), .direction = 'updown') |>
  unique() |>
  ungroup() |>
  select(-Transaction)

Headers <- Remove_Empty[Headers_Pos, ] |>
  select_if(function(x) !(all(is.na(x)))) |>
  row_to_names(1)

names(Cleaning) <- names(Headers)

Cleaning$Date <- janitor::excel_numeric_to_date(Cleaning$Date |> as.numeric())

Cleaning |>
  view()
