# Summarize the table for each month to show Customers, Totals Sales & Rank in that particular month on the basis of Sales.
# Sales Amount = Quantity * Price (Banana:4:1.13 => 4 is quantity and 1.13 is price)

library(EBI)
library(tidyverse)

df <- Excel_Bi_File(from = "A1", to = "A51")


Headers <- str_split_1(names(df), pattern = ",")

Answer <- df |>
  separate_wider_delim(
    cols = `OrderID,OrderDate,Customer,Items`,
    delim = ',',
    names = Headers
  ) |>
  separate_longer_delim(cols = Items, delim = ';') |>
  mutate(
    Item = str_extract(Items, pattern = '^[a-zA-Z]+'),
    Quantity = str_extract(Items, pattern = '(?<=:)\\d+') |> as.numeric(),
    Price = str_extract(Items, pattern = '\\d+\\.\\d+$') |> as.numeric(),
    Quarter = quarter(OrderDate),
    .keep = "unused"
  ) |>
  summarise(
    Total_Amount = sum(Quantity * Price),
    .by = c(Quarter, Customer)
  ) |>
  slice_max(order_by = Total_Amount, n = 3, by = Quarter) |>
  mutate(Quarter = paste0("Q", Quarter), Rank = row_number(), .by = Quarter) |>
  arrange(Quarter, Rank)

Answer |>
  view()
