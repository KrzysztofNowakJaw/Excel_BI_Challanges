#https://crispomwangi-my.sharepoint.com/:x:/g/personal/crispo_crispexcel_com/IQAzgwKI7vG7QZapjWc5O_-rAWSgaYevX9P_mSqP4VXPrXM?rtime=grhR_nlh3kg

library(tidyverse)

df <- data.frame(
  Items = c("Apple", "Mango", "Kiwi")
)


Repeats <- data.frame(
  Repeats = c(4, 2),
  Item = c(2, 3)
)

df |>
  mutate(Item = row_number(), .before = 1) |>
  left_join(Repeats) |>
  mutate(Repeats = if_else(is.na(Repeats), true = 1, false = Repeats)) |>
  uncount(Repeats)
