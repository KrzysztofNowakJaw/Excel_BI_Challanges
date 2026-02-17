#https://docs.google.com/spreadsheets/d/1-r7VdhVa7KrUBY4ND8EKmWBv9dIOm5Jy/edit?gid=1606114551#gid=1606114551
library(tidyverse)
library(EBI)


df <- Excel_Bi_File(from = "B3", to = "E10")

Break <- median(1:nrow(df))

df |>
  filter_out(row_number() == Break) |>
  mutate(Ids = row_number() > (nrow(df) - 1) / 2) |>
  summarise(Sales = sum(`Total Sales`), .by = Ids) |>
  arrange(Sales) |>
  mutate(
    Sales = if_else(row_number() == 1, Sales + df$`Total Sales`[Break], Sales),
    Ids = paste("Group", row_number())
  ) |>
  view()
