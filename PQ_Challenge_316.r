library(tidyverse)

df = read_xlsx(File_name, range = 'A1:C18')

Answer <- df |>
  fill(Continent, .direction = 'down') |>
  group_by(Continent) |>
  mutate(
    Index = row_number(),
    N = n(),
    InternalIndex = rep(1:ceiling(N / 3), each = 3)[1:N],
    Country = paste(Country, as.character(Medals)),
    ContinentHeader = paste(Continent, as.character(InternalIndex))
  ) |>
  ungroup() |>
  summarise(Country = paste(Country, collapse = '-'), .by = ContinentHeader) |>
  separate_wider_delim(
    Country,
    delim = '-',
    names = c("C1", "C2", "C3"),
    too_few = "align_start"
  ) |>
  mutate(ContinentHeader = str_remove(ContinentHeader, pattern = "\\s\\d+"))


Answer
