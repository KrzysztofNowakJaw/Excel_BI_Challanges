#Link to challange
#https://www.linkedin.com/posts/omid-motamedisedeh-74aba166_powerabrquery-excel-powerabrqueryabrtips-activity-7247349637949337600-yaO5?utm_source=share&utm_medium=member_desktop
library(tidyverse)
library(readxl)

df <- read_excel(my_files, range = 'C2:E27')

regions <- df |>
  mutate(Region = str_extract_all(Date, '[A-Z].*')) |>
  select(Region) |>
  unnest(Region) |>
  na.omit() |>
  mutate(Index = row_number())

dates <- df |>
  mutate(
    Date = str_extract_all(Date, '\\d.*'),
    .after = Qty
  ) |>
  select(Date) |>
  unnest(Date) |>
  na.omit() |>
  mutate(
    date = as.Date(Date, format = "%d/%m/%Y"),
    Index = row_number()
  )

df |>
  select(2:3) |>
  mutate(Index = consecutive_id(!is.na(Description))) |>
  filter(!is.na(Description)) |>
  mutate(Index = dense_rank(Index)) |>
  left_join(regions) |>
  left_join(dates) |>
  arrange(date) |>
  select(date, Region, Description, Qty)
