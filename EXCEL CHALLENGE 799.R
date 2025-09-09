#https://onedrive.live.com/personal/e11b26eeaacb7947/_layouts/15/Doc.aspx?sourcedoc=%7Bbf72dc4e-f64c-4daf-82ed-ae4da8816cb9%7D&action=default&redeem=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0VVN2NjcjlNOXE5Tmd1MnVUYWlCYkxrQkpqWWh0WjFjRkgzczhHTW1ualZfY2c_ZT1ZSHkycjA&slrid=7613c4a1-d0a5-a000-2621-d457fcdc9a39&originalPath=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0VVN2NjcjlNOXE5Tmd1MnVUYWlCYkxrQkpqWWh0WjFjRkgzczhHTW1ualZfY2c_cnRpbWU9blRycmhMUHYzVWc&CID=08af313d-3abf-4fd6-84b0-42ae8ca20f11&_SRM=0:G:55

library(tidyverse)

df <- read_xlsx(File_name,range = "A2:B6")

df |>
  mutate(Band = str_extract_all(Band,pattern = '\\d+-\\d+')) |>
  unnest(cols = Band) |>
  separate_longer_delim(Band,delim = ", ") |>
  separate_wider_delim(Band,delim = "-",names = c("Min","Max")) |>
  mutate(across(2:3, ~ as.numeric(.))) |>
  group_by(Index = row_number()) |>
  complete(Min = seq(from = min(Min),to = max(Max),by = 1)) |>
  rename(Answer = Min) |>
  ungroup() |> 
  fill(Product) |>
  select(Product,Answer)

