#https://www.linkedin.com/posts/omidmot_exclude-powerabrquery-excel-activity-7444851025464705024-fxfk?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0

library(tidyverse)
library(janitor)
library(readxl)

df <- read_xlsx(File_name, range = "B3:E6")
EX <- read_xlsx(File_name, range = "G3:I9")


Answer <- df |>
  split(df$col1) |>
  map(\(df) {
    df |>
      pivot_longer(everything()) |>
      select(2)
  }) |>
  bind_cols() |>
  janitor::row_to_names(1) |>
  mutate(Dates = str_remove_all(Dates, '\\s')) |>
  separate_longer_delim(Dates, delim = ",")


Answer
