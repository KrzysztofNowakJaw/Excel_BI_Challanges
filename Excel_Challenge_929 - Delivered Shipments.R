library(tidyverse)
library(readxl)
library(gt)

df <- read_xlsx(File_name, range = "A2:A22")

Calculate <- df |>
  separate_wider_delim(
    Data,
    delim = '_',
    names = c('Date', 'Truck ID', 'Trans', 'Value')
  ) |>
  filter(Trans == 'DELIVERED') |>
  mutate(Value = str_remove(Value, '^\\$')) |>
  summarise(
    'Total Revenue' = sum(as.numeric(Value)),
    `Last Delivery Date` = max(Date),
    .by = `Truck ID`
  ) |>
  arrange(`Truck ID`)

Calculate |>
  gt() |>
  fmt_currency(
    columns = "Total Revenue",
    currency = 'dollar',
    #'euro'
    #'yen'
    use_subunits = TRUE,
    decimals = 2,
  )
