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

library(tidyverse)
library(readr)

Diff_Prod <- df |>
  inner_join(df, join_by(Order_ID), relationship = "many-to-many") |>
  filter(Product.x != Product.y) |>
  select(Order_ID, Product.x, Product.y) |>
  mutate(
    Comb = pmap_chr(
      list(Product.x, Product.y),
      ~ paste(c(...), collapse = "-")
    )
  ) |>
  group_by(Order_ID) |>
  select(Order_ID, Comb) |>
  unique() |>
  ungroup() |>
  add_count(Comb) |>
  select(Comb, n) |>
  unique() |>
  separate_wider_delim(cols = Comb, names = c("P1", "P2"), delim = "-")


S <- df |>
  summarise(
    n = n(),
    .by = Product
  ) |>
  mutate(P2 = Product, .after = Product) |>
  rename(P1 = Product)


Binded <- bind_rows(Diff_Prod, S) |> arrange(P1, P2) |> uncount(n)

Result <- table(Binded$P1, Binded$P2)

Result
