#https://onedrive.live.com/:x:/g/personal/E11B26EEAACB7947/EUEMLl12AuFChgjAW7GWFJsB6Or6g2UtAYeqBtOqGDh5sw?resid=E11B26EEAACB7947!s5d2e0c41027642e18608c05bb196149b&ithint=file%2Cxlsx&e=6Blcod&migratedtospo=true&redeem=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0VVRU1MbDEyQXVGQ2hnakFXN0dXRkpzQjZPcjZnMlV0QVllcUJ0T3FHRGg1c3c_ZT02Qmxjb2Q

library(tidyverse)
library(readxl)

df <- read_xlsx(list.files(pattern = ".+xlsx")[2], range = "A1:D11")
df <- df |> add_column(Index = 1:nrow(df), .before = 1)

Dimensions <- df |>
  filter(Index %% 2 == 0) |>
  pivot_longer(2:ncol(df)) |>
  mutate(
    Age = str_split_i(string = value, pattern = ", ", i = 1),
    Nationality = str_split_i(string = value, pattern = ", ", i = 2),
    Salary = str_split_i(string = value, pattern = ", ", i = 3)
  ) |>
  drop_na() |>
  select(-c(value, Index)) |>
  mutate(InternalIndex = row_number(), .by = name, .before = name)

People <- df |>
  filter(Index %% 2 != 0) |>
  pivot_longer(2:ncol(df)) |>
  drop_na() |>
  mutate(InternalIndex = row_number(), .by = name, .before = name)

Answer <- People |>
  left_join(Dimensions, join_by(name, InternalIndex)) |>
  arrange(name, InternalIndex) |>
  rename(
    Dept = name,
    Employee = value
  ) |>
  mutate(Dept = factor(Dept, unique(Ex$Dept))) |>
  arrange(Dept) |>
  select(!contains("Index")) |>
  unique() |>
  view()
