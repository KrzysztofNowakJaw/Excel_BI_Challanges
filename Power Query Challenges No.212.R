#Link to challange
#https://www.linkedin.com/posts/omidmot_powerabrquery-excel-powerabrqueryabrtips-activity-7312579462611513346-1v9p?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0
library(tidyverse)

df |>
  pivot_longer(everything()) |>
  group_by(value) |>
  mutate(Count_list = n_distinct(name)) |>
  filter(Count_list == 1) |>
  select(value) |>
  unique()
