# https://www.linkedin.com/posts/omidmot_exclude-powerabrquery-excel-activity-7460071307557281792-H_fL?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0

library(tidytext)
library(readxl)
library(tidyverse)

df <- read_xlsx(File_name, range = "B3:B9")

Mapping <- data.frame(
  to = rep(paste0("ID", 1:4), each = 4),
  from = as.vector(sapply(1:4, function(i) i + (0:3) * 3))
)

Answer <- df |>
  mutate(Index = row_number()) |>
  group_by(Index) |>
  unnest_characters(
    input = ID,
    output = Split,
    strip_non_alphanum = FALSE,
    to_lower = FALSE
  ) |>
  mutate(
    Position = row_number(),
    Position = recode_values(Position, from = Mapping$from, to = Mapping$to)
  ) |>
  ungroup() |>
  summarize(Values = paste(Split, collapse = ""), .by = c(Index, Position)) |>
  group_by(Index) |>
  pivot_wider(id_cols = Index, names_from = Position, values_from = Values) |>
  ungroup() |>
  select(-Index)

Answer
