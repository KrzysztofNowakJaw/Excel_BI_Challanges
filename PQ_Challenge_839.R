#https://onedrive.live.com/:x:/g/personal/E11B26EEAACB7947/ESWz4PWjYJBHq2g1IAREH7UB67HrEC7OI5etAJoiegybIg?resid=E11B26EEAACB7947!sf5e0b32560a34790ab68352004441fb5&ithint=file%2Cxlsx&e=WXfAPt&migratedtospo=true&redeem=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0VTV3o0UFdqWUpCSHEyZzFJQVJFSDdVQjY3SHJFQzdPSTVldEFKb2llZ3liSWc_ZT1XWGZBUHQ
library(tidyverse)

df <- read_xlsx(File_name, range = "A1:A7")

Answer <- df |>
  mutate(
    Index = row_number(),
    Data = str_remove(Data, '\\s[A-Z]{3}(?=\\s\\()')
  ) |>
  group_by(Index) |>
  separate_wider_regex(
    Data,
    c(
      Country = '^[A-Z]+[a-z]+?\\s.*(?=\\()',
      Sep1 = '\\(',
      Time_Zone = '.*',
      Sep2 = '\\)',
      Coord = '.*'
    )
  ) |>
  mutate(
    across(everything(), \(x) trimws(x)),
    Coord = str_extract_all(Coord, '[A-Z]{3,}\\s-?\\d+\\.\\d+')
  ) |>
  unnest(Coord) |>
  separate_wider_delim(cols = Coord, delim = " ", names = c("1", "2")) |>
  pivot_wider(names_from = `1`, values_from = `2`) |>
  ungroup() |>
  select(!contains(c("Sep", "Index"))) |>
  rename(Latitude = LAT, Longitude = LONG) |>
  view()
