#https://www.linkedin.com/posts/excelbi_excel-challenge-problem-activity-7397121533757804544-odio?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0

library(tidyverse)
library(janitor)

df <- data.frame(
  Items = c("A-B-C", "C*Q*A", "B$A", "A@B@Q"),
  Amount = c("80-90-10", "30*40*50", "80$35", "45@95@0"),
  stringsAsFactors = FALSE
)


df |>
  mutate(
    ItemSep = str_extract_all(Items, pattern = '[A-Z]'),
    Values = str_extract_all(Amount, pattern = '\\d+')
  ) |>
  unnest(3:4) |>
  summarise(Result = sum(as.numeric(Values)), .by = ItemSep) |>
  adorn_totals()
