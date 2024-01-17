#link to challange:
#https://www.linkedin.com/feed/update/urn:li:activity:7153234484769763331/

library(tidyverse)
library(readxl)

# Read data from Excel file and clean column names
df <- read_xlsx("Excel_Challenge_371 - Find data between dates.xlsx", range = "A1:F8") |> janitor::clean_names()

Range <- read_xlsx("Excel_Challenge_371 - Find data between dates.xlsx", range = "H1:I2") |> janitor::clean_names()

RangePivoted <- Range |>
  mutate(across(everything(),\(x) as.Date(x))) |>
  pivot_longer(everything(),values_to = "Dates") |>
  complete(Dates = seq.Date(from = min(Dates),to = max(Dates),by = "day"))

Answer <- df |>
  mutate(across(2:ncol(df),\(x) as.Date(x))) |>
  pivot_longer(cols = -c(products),values_to = "Dates") |>
  filter(!is.na(Dates)) |>
  semi_join(RangePivoted,by = "Dates") |>
  arrange(Dates,products) |>
  summarise(Answer = paste(products,collapse = ","),.by = Dates)

Answer

