library(readxl)
library(tidyverse)


df <- read_xlsx(File_name, range = "A1:D21") |>
  mutate(Timestamp = hms::as_hms(Timestamp))


df |>
  mutate(Timestamp = hms::as_hms(Timestamp)) |>
  group_by(Player) |>
  mutate(
    Valid = coalesce(Points >= lag(Points), TRUE) &
      coalesce(Timestamp - lag(Timestamp) <= 5, TRUE),
    G = cumsum(Valid == FALSE)
  ) |>
  ungroup() |>
  summarise(
    Start = first(Timestamp),
    End = last(Timestamp),
    Moves = n(),
    Points = sum(Points),
    .by = c(Player, G)
  ) |>
  select(-G) |>
  view()
