# link to challange
# https://www.linkedin.com/posts/excelbi_excel-challenge-problem-activity-7234046991758983168-e1MZ?utm_source=share&utm_medium=member_desktop

library(tidyverse)
library(readxl)
library(janitor)


df <- read_xlsx("Excel_Challenge_530 - Dates for Max Sales.xlsx", range = c("A2:I11")) |> clean_names()

Answer <- df |>
  rowwise() |>
  mutate(
    across(contains("date"), \(x) as.Date(x)),
    Periods = list(c_across(where(is.Date))),
    Values = list(c_across(where(is.numeric))),
    MaxVal = max(c_across(where(is.numeric)))
  ) |>
  select(name, MaxVal, Periods, Values) |>
  unnest_longer(Values) |>
  group_by(name) |>
  mutate(Index = row_number()) |>
  filter(MaxVal == Values) |>
  rowwise() |>
  mutate(Answer = Periods[Index]) |>
  ungroup() |>
  summarise(Answer = paste(as.character(Answer), collapse = ","), .by = c(name, MaxVal))

Answer 
