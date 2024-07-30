library(tidyverse)
library(readxl)

# Define the filename of the Excel file containing the grid data
filename <- "PQ_Challenge_204.xlsx"

df <- read_xlsx(filename, range = "A1:D7")

Pivoted <- df |>
  pivot_longer(everything())


Transposed <- Pivoted |>
  cross_join(Pivoted) |>
  filter(value.x == value.y & name.x != name.y) |>
  arrange(name.x, name.y) |>
  mutate(Source = str_c(name.y, paste(value.y, collapse = ","), sep = "-"), .by = c(name.x, name.y)) |>
  select(name.x, Source) |>
  unique() |>
  mutate(
    Answer = str_count(Source, "(?<=-|,)[[:alpha:]]"),
    Source = str_remove(Source, "(?<=Col\\d).*")
  ) |>
  pivot_wider(id_cols = name.x, names_from = Source, values_from = Answer)

Order <- sort(names(Transposed[2:ncol(Transposed)]))

Answer <- Transposed |>
  select(name.x, all_of(Order)) |>
  pivot_longer(cols = contains("Col")) |>
  filter(!is.na(value)) |>
  mutate(Combined = str_c(name, value, sep = "-")) |>
  group_by(name.x) |>
  mutate(Index = row_number()) |>
  complete(Index = seq(1, 3, 1)) |>
  ungroup() |>
  summarise(Match = list(Combined), .by = name.x) |>
  pivot_wider(
    names_from = name.x,
    names_glue = "{name.x}_{.value}",
    values_from = Match
  ) |>
  unnest(everything())

Answer
