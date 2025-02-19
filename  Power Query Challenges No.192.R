# Link to challange
#https://www.linkedin.com/posts/omidmot_powerabrquery-excel-powerabrqueryabrtips-activity-7298083961073741824-89-a?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0
library(tidyverse)
library(readxl)

Answer <- df |>
  mutate(Index = row_number()) |>
  mutate(IsNeg = consecutive_id(Quantity < 0),.by = Product) |>
  arrange(Product,IsNeg,desc(Date)) |>
  mutate(QS= cumsum(abs(Quantity)),.by = c(Product,IsNeg)) |>
  slice_max(order_by = QS,n = 1,by = c(Product,IsNeg)) |>
  mutate(QS = case_when(lead(Quantity) < 0 ~ QS - lead(QS),.default = QS),.by = Product) |>
  filter(QS > 0 & Quantity > 0) |>
  arrange(Index) |>
  select(Date,Product,QS)