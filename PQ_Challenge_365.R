#https://onedrive.live.com/:x:/g/personal/E11B26EEAACB7947/IQBXiXfl7ss1TISekWDzsVCgAcKby3pIiNV96ItqYq6ykqE?resid=E11B26EEAACB7947!se5778957cbee4c35849e9160f3b150a0&ithint=file%2Cxlsx&e=uUH7vs&migratedtospo=true&redeem=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0lRQlhpWGZsN3NzMVRJU2VrV0R6c1ZDZ0FjS2J5M3BJaU5WOTZJdHFZcTZ5a3FFP2U9dVVIN3Zz
library(EBI)
library(tidyverse)

df <- Excel_Bi_File(from = "A1", to = "A19")

df <- df |>
  mutate(Index = row_number(), Result = str_extract(Data, 'Success|Failure')) |>
  fill(Result, .direction = "up")

Ends <- df |>
  filter(str_detect(Data, 'END')) |>
  filter_out(str_detect(Data, "Failure")) |>
  select(-Data, Result) |>
  mutate(ProcessID = row_number())

Answer <- df |>
  left_join(Ends, join_by(closest(Index <= Index))) |>
  separate_longer_delim(Data, ':') |>
  filter(str_detect(Data, '_') & Result.x != 'Failure') |>
  separate_wider_delim(Data, delim = '_', names = c('Type', 'value')) |>
  select(contains(c('Type', 'value', 'ProcessID'))) |>
  pivot_wider(id_cols = c(ProcessID), names_from = Type, values_from = value) |>
  unnest(everything())

Answer
