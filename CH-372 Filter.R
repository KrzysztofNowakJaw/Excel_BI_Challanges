#https://docs.google.com/spreadsheets/d/1U6WDXfzksGr4zm4fZBSaUpBKjp7d0QW0/edit?gid=493106675#gid=493106675

library(tidyverse)

df <- tibble(
  ID = c(
    "MN12Q",
    "MNMN!Q",
    "F12312Q1",
    "UMNMQUNMM",
    "MMQN89",
    "QQQ",
    "MNNUM"
  )
)

df |>
  mutate(Numbers = str_extract_all(ID, '\\d{1}')) |>
  unnest(cols = Numbers) |>
  filter(as.numeric(Numbers) %% 2 != 0) |>
  select(ID) |>
  distinct()
