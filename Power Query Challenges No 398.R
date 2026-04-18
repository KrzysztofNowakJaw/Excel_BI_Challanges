#https://www.linkedin.com/posts/omidmot_exclude-powerabrquery-excel-activity-7450649225350221824-mLZ9?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0

library(readxl)
library(tidyverse)

df <- read_xlsx(File_name, range = "B3:E10")

Ex <- read_xlsx(File_name, range = "G3:J10")

Sorted <- df |>
  slice(2:nrow(df)) |>
  bind_rows(
    df |> head(1)
  ) |>
  pull(`Product ID`)

df$`Product ID` <- Sorted
