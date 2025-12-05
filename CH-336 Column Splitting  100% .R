#https://docs.google.com/spreadsheets/d/1KEDcGeTofK_zj4W5DldaJhRgyf-FD2qK/edit?pli=1&gid=347420386#gid=347420386
library(tidyverse)
library(tidytext)

df <- data.frame(
  ID = c(
    'XMS128',
    'F1M810',
    'MMKN',
    '12AA21',
    'F19'
  )
)


df |>
  unnest_characters(input = ID, output = R, to_lower = FALSE, drop = FALSE) |>
  mutate(
    Index = consecutive_id(str_detect(R, pattern = '\\d+')),
    .by = ID,
    .before = 1
  ) |>
  summarise(Values = paste(R, collapse = ""), .by = c(ID, Index)) |>
  pivot_wider(
    id_cols = ID,
    names_from = Index,
    values_from = Values,
    names_prefix = "ID"
  ) |>
  select(-c(ID)) |>
  view()
