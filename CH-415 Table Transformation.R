library(tidyverse)
library(readxl)
library(janitor)

df <- read_xlsx("CH-415 Table Transformation (1).xlsx", range = "B3:C23")

Index <- df |>
  mutate(Index = consecutive_id(str_extract(COLUMN, '^[A-Z]+')), .before = 1)

Answer <- Index |>
  select(-c(Index, COLUMN)) |>
  group_split(Index$Index) |>
  bind_cols() |>
  select(-starts_with("Index"))

names(Answer) <- str_remove_all(df$COLUMN, '\\d+') |> unique() |> str_to_upper()

Answer <- Answer |>
  mutate(DATE = excel_numeric_to_date(as.numeric(DATE))) |>
  view()
