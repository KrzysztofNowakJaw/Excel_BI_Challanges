#Link To Challenge
#https://www.linkedin.com/feed/update/urn:li:activity:7152147318102728705/

library(tidyverse)
library(readxl)

df <- read_xlsx("Power_Query_Challenge_148.xlsx", range = "A1:A12")
Expected <- read_xlsx("Power_Query_Challenge_148.xlsx", range = "C1:N12")

Expected <- Expected |>
  mutate(across(2:ncol(Expected), \(x) as.numeric(x)))

Answer <- df |>
  separate_longer_delim(Fruits, ", ") |>
  group_by(Fruits) |>
  mutate(Count = n()) |>
  arrange(Fruits) |>
  unique() |>
  mutate(Headers = Fruits) |>
  pivot_wider(id_cols = Fruits, names_from = Headers, values_from = Count)
