#https://www.linkedin.com/posts/excelbi_excel-challenge-problem-activity-7442782383696670720-0qUJ?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0
library(tidyverse)
library(readr)


df <- data.frame(
  Order_ID = c(
    "O-1001",
    "O-1001",
    "O-1001",
    "O-1002",
    "O-1002",
    "O-1003",
    "O-1003",
    "O-1004",
    "O-1004",
    "O-1004",
    "O-1005",
    "O-1005",
    "O-1005",
    "O-1006",
    "O-1006",
    "O-1006",
    "O-1007",
    "O-1007",
    "O-1008",
    "O-1008"
  ),
  Product = c(
    "Coffee",
    "Sugar",
    "Milk",
    "Coffee",
    "Pastry",
    "Tea",
    "Honey",
    "Coffee",
    "Sugar",
    "Pastry",
    "Tea",
    "Milk",
    "Honey",
    "Coffee",
    "Milk",
    "Pastry",
    "Tea",
    "Pastry",
    "Coffee",
    "Sugar"
  )
)


#Simplified

R <- df |>
  inner_join(df, join_by(Order_ID), relationship = "many-to-many") |>
  select(Order_ID, Product.x, Product.y) |>
  mutate(
    Comb = paste(Product.x, Product.y, sep = "-"),
    .keep = "used"
  ) |>
  separate_wider_delim(cols = Comb, names = c("P1", "P2"), delim = "-")


table(R$P1, R$P2)

#Old version
Diff_Prod_New <- df |>
  inner_join(df, join_by(Order_ID), relationship = "many-to-many") |>
  select(Order_ID, Product.x, Product.y) |>
  mutate(
    Comb = pmap_chr(
      list(Product.x, Product.y),
      ~ paste(c(...), collapse = "-")
    ),
    .keep = "used"
  ) |>
  add_count(Comb) |>
  select(Comb, n) |>
  unique() |>
  separate_wider_delim(cols = Comb, names = c("P1", "P2"), delim = "-") |>
  uncount(n)

Result <- table(Diff_Prod_New$P1, Diff_Prod_New$P2)

Result
Diff_Prod_New
