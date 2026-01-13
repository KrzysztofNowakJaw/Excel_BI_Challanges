#https://crispomwangi-my.sharepoint.com/:x:/g/personal/crispo_crispexcel_com/IQDYY4p87CNmSZeOVLNPvJjDAbBrf5T_PwOh14hzAsGWZfs?rtime=K4QleOFS3kg
library(tidyverse)
library(tidytext)

df <- read_xlsx(File_name, range = "B2:B8")

df |>
  unnest_tokens(
    input = Address,
    output = Words,
    token = 'regex',
    pattern = ',\\s',
    to_lower = FALSE,
    drop = FALSE
  ) |>
  filter(str_detect(Words, '\\d{5}\\s[a-zA-Z]')) |>
  separate_wider_delim(
    Words,
    ' ',
    names = c("Code", "City"),
    too_many = "merge"
  ) |>
  select(City)
