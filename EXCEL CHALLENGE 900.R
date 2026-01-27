df <- read_xlsx(File_name, range = "A2:C52")

Dates <- df |>
  mutate(
    Qrt = paste(year(Date), quarter(Date), sep = '-'),
    Month_Year = paste(year(Date), month(Date), sep = '-')
  )

Qty_Avg <- Dates |>
  summarise(Avg = mean(Sales), .by = Qrt)

Dictionary <- Dates |>
  mutate(Month_Name = format(Date, '%b')) |>
  select(Month_Year, Month_Name) |>
  unique()

Dates |>
  summarise(Sales = sum(Sales), .by = c(Salesperson, Qrt, Month_Year, Date)) |>
  inner_join(Qty_Avg) |>
  mutate(
    Is_Higher = cumsum(Sales > Avg),
    Transactions = n(),
    .by = c(Salesperson, Qrt, Month_Year)
  ) |>
  slice_max(order_by = Is_Higher, n = 1, by = c(Salesperson, Month_Year)) |>
  filter(Is_Higher == Transactions) |>
  summarise(Result = paste(Salesperson, collapse = ", "), .by = Month_Year) |>
  mutate(Index = str_extract(Month_Year, pattern = "\\d+$") |> as.numeric()) |>
  complete(Index = seq(from = min(Index), to = max(Index))) |>
  mutate(
    Month_Year = case_when(
      is.na(Month_Year) ~ paste(
        str_extract(lag(Month_Year), pattern = "^\\d+"),
        as.character(Index),
        sep = '-'
      ),
      .default = Month_Year
    )
  ) |>
  inner_join(Dictionary) |>
  select(Month_Name, Result) |>
  view()
