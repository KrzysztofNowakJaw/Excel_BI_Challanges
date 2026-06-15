#https://www.linkedin.com/posts/excelbi_challenge-powerquerychallenge-daxchallenge-activity-7471773417067696128-qr83?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0
library(readxl)
library(tidyverse)
library(janitor)


df <- read_xlsx("PQ_Challenge_400.xlsx", range = "A1:A12")

Mapping <- tibble(
  status = c("Blocked", "Review", "Open", "Closed"),
  to = 1:4
)

df <- df |>
  separate_wider_delim(
    cols = Event,
    delim = ",",
    names = c('Entity', 'Start Date', 'End Date', 'Status')
  ) |>
  clean_names() |>
  mutate(
    across(ends_with("date"), \(x) as.Date(x, format = "%d-%b-%Y"))
  )

Calendar <- tibble(
  Dates = seq.Date(
    from = min(df$start_date, df$end_date),
    to = max(df$start_date, df$end_date),
    by = "day"
  )
)


Answer <- Calendar |>
  left_join(df, join_by(between(Dates, start_date, end_date))) |>
  left_join(Mapping) |>
  group_by(Dates, entity) |>
  slice_min(order_by = to, n = 1) |>
  ungroup() |>
  mutate(to = consecutive_id(status), .by = entity) |> # grupowanie per entity
  summarise(
    start_date = min(Dates),
    end_date = max(Dates),
    final_status = first(status),
    .by = c(entity, to)
  ) |>
  arrange(entity) |>
  select(-to)


Answer
