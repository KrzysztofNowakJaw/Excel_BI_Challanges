#https://onedrive.live.com/:x:/g/personal/e11b26eeaacb7947/IQD2zXBVNsVqToND6h04yg7EASlpKVHC8F5HhOvJISJZ9zM?rtime=nyYh31OV3kg&redeem=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0lRRDJ6WEJWTnNWcVRvTkQ2aDA0eWc3RUFTbHBLVkhDOEY1SGhPdkpJU0paOXpNP2U9QUtDQWJE

library(tidyverse)
library(readxl)


df <- read_xlsx(File_name, range = "A1:A23")

df |>
  cross_join(df) |>
  filter((Data.x != Data.y) & nchar(Data.x) == nchar(Data.y)) |>
  rowwise() |>
  mutate(
    X_Split = list(str_split_1(Data.x, "")),
    Y_Split = list(str_split_1(Data.y, ""))
  ) |>
  filter(length(setdiff(X_Split, Y_Split)) == 0) |>
  ungroup() |>
  reframe(Anagrams = list(Data.y), .by = Data.x) |>
  rowwise() |>
  mutate(
    Anagrams = list(sort(append(Data.x, Anagrams))),
    Anagrams = paste(Anagrams, collapse = ", ")
  ) |>
  select(Anagrams) |>
  unique()
