#https://www.linkedin.com/posts/omidmot_exclude-powerabrquery-excel-activity-7401002086764826624-iv5W?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0

library(tidyverse)

df <- read_xlsx(File_name, range = "B2:D11") |> janitor::clean_names()

OutOfScope <- df |>
  arrange(issue_id, date) |>
  mutate(
    Index = row_number(),
    Last = n(),
    .by = issue_id
  ) |>
  filter(Index == Last & status == "Close")


df |>
  filter(!(issue_id %in% OutOfScope$issue_id)) |>
  select(issue_id) |>
  unique()
