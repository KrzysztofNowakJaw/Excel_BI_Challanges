#https://docs.google.com/spreadsheets/d/11CvR_soN3XtHGa93EQaS74hs5Dx0cSvA/edit?gid=1261307793#gid=1261307793

library(readxl)
library(tidyverse)

df <- read_xlsx(File_name, range = "B3:F23")

Answer <- df |>
  mutate(RN = row_number()) |>
  group_split(Customer) |>
  map(\(df) {
    df |>
      mutate(Index = consecutive_id(Product)) |>
      mutate(Index = if_else(n() > 1, "*", ""), .by = Index)
  }) |>
  bind_rows() |>
  arrange(RN) |>
  select(-RN)

Answer
