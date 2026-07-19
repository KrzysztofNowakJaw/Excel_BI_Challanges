df <- read_xlsx(File_name, range = "B3:C12") |> janitor::clean_names()

df |>
  mutate(Index = consecutive_id(stock_bal == 0)) |>
  group_by(Index) |>
  mutate(
    Date = first(date),
    How_Long = row_number()
  ) |>
  ungroup() |>
  filter_out(stock_bal > 0) |>
  slice_tail(n = 1, by = Date) |>
  select(-c(Index, date, stock_bal)) |>
  view()
