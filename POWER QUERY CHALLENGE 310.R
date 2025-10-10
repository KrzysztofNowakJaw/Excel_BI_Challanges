library(tidyverse)
library(readxl)


df <- read_xlsx(File_name, range = "A1:D13")

Answer <- df |>
  fill(everything(), .direction = "down") |>
  group_by(Name) |>
  mutate(Index = row_number()) |>
  fill(everything(), .direction = "up") |>
  filter(Index == max(Index)) |>
  select(-Index)

Answer
