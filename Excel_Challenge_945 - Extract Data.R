library(tidyverse)
library(readxl)

df <- read_xlsx(File_name, range = "A2:A26")

Answer <- df |>
  filter_out(Data == '---') |>
  mutate(Index = cumsum(str_detect(Data, "USER")), .before = 1) |>
  separate_wider_delim(Data, delim = ": ", names = c("Type", "Data")) |>
  group_by(Index) |>
  filter(Type %in% c("USER", "DATE", "ACTION", "STATUS", "SIZE")) |>
  pivot_wider(id_cols = Index, names_from = Type, values_from = Data) |>
  filter(DATE == '2026-03-30') |>
  mutate(
    STATUS = if_else(
      !is.na(SIZE),
      paste(STATUS, SIZE, collapse = " "),
      false = STATUS
    ),
    .keep = "unused"
  ) |>
  ungroup() |>
  select(-c(Index, DATE))

Answer
