#https://www.linkedin.com/posts/excelbi_excel-challenge-problem-activity-7451842102562471936-BwJO?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0
library(readxl)
library(tidyverse)

df <- read_xlsx(File_name, range = "A2:B36")

T1 <- df |>
  cross_join(df) |>
  rename(Item1 = SKU.x, Item2 = SKU.y) |>
  filter(Item1 != Item2 & TxnID.x == TxnID.y) |>
  select(-starts_with('TxnID'))


Answer <- T1 |>
  arrange(Item1, Item2) |>
  rowwise() |>
  mutate(
    Index = row_number(),
    Comb = list(sort(c_across(starts_with('Item'))))
  ) |>
  ungroup() |>
  mutate(Index = row_number(), .before = 1) |>
  unnest(Comb) |>
  summarise(Comb = paste(Comb, collapse = "-"), .by = Index) |>
  summarise('Basket Count' = n() / 2, .by = Comb) |>
  separate_wider_delim(Comb, names = c("Item1", "Item2"), delim = "-")

Answer
