library(tidyverse)
library(readxl)

df <- read_xlsx("CH-417 Custom Grouping.xlsx", range = "B3:D12")

Answer <- df |>
  rowwise() |>
  mutate(ROW = paste(sort(c(FROM, TO)), collapse = "-")) |>
  ungroup() |>
  group_by(ROW, Index = consecutive_id(ROW)) |>
  summarise(Answer = sum(QUANTITY), .groups = "drop_last") |>
  select(-Index)

#Different Result
Answer
