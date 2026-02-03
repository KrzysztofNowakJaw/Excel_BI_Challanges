#https://docs.google.com/spreadsheets/d/11zOvSBEALSNFVdAAUyK9jEOmlWaP5FQM/edit?gid=746760720#gid=746760720

library(EBI)
library(tidyverse)

df <- EBI::Excel_Bi_File(from = "B3", to = 'E10')

Result <- df |>
  add_count(`Customer ID`) |>
  mutate(
    `Customer ID` = case_when(n == 1 ~ "Other", .default = `Customer ID`)
  ) |>
  summarise(IDs = sum(`Total Sales`), .by = `Customer ID`)

Result
