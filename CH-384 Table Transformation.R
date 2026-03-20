#https://www.linkedin.com/posts/omidmot_exclude-powerabrquery-excel-activity-7440502384104996864-GKwF?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0

df <- read_xlsx(File_name, range = "B3:E11")

Pivoted <- df |>
  fill(Customer, .direction = "down") |>
  group_by(Customer) |>
  fill(Date, .direction = "down") |>
  pivot_longer(cols = 3:4) |>
  filter_out(is.na(value)) |>
  ungroup() |>
  fill(Date, .direction = "down") |>
  mutate(
    Group = if_else(
      str_detect(value, '\\d+'),
      "Sale",
      "Product"
    )
  ) |>
  mutate(Position = row_number(), .by = c(Customer, Group), .before = 1) |>
  group_by(Customer, Position) |>
  pivot_wider(
    id_cols = c(Position, Date, Customer),
    names_from = Group,
    values_from = value
  ) |>
  ungroup() |>
  select(-Position)

Broked_dates <- which(str_detect(Pivoted$Date, '\\.'))

Pivoted$Date[Broked_dates] <- as.Date(
  as.numeric(Pivoted$Date[Broked_dates]),
  origin = "1899-12-30"
) |>
  format("%m/%d/%Y")

Pivoted |> view()
