library(tidyverse)
library(janitor)


df <- read_xlsx(File_name, range = "B3:B12")

Ex <- read_xlsx(File_name, range = "D3:F9")

Ex <- Ex |>
  slice(1:4) |>
  mutate(
    Date = janitor::excel_numeric_to_date(as.numeric(Date)) |> as.character()
  ) |>
  bind_rows(
    Ex |>
      slice(5:6)
  )


Split <- df |>
  mutate(
    Col1 = str_remove_all(Col1, '\\s')
  ) |>
  separate_longer_delim(Col1, delim = ',') |>
  mutate(Index = row_number())


Cleaned_Dates <- rows_update(
  x = Split,
  y = Split |>
    filter(lag(row_number()) %% 3 == 0 & !str_detect(Col1, '\\/')) |>
    mutate(
      Col1 = excel_numeric_to_date(as.numeric(Col1)),
      Col1 = format(Col1, '%m/%d/%Y')
    ),
  by = "Index"
)

Answer <- Cleaned_Dates |>
  mutate(
    Index = cumsum(
      case_when(str_detect(Col1, '\\/') ~ 1, .default = 0)
    ),
    Header = rep(c("Date", "Product", "Sale"), nrow(Cleaned_Dates) / 3)
  ) |>
  group_by(Index) |>
  pivot_wider(names_from = Header, values_from = Col1) |>
  ungroup() |>
  select(-Index)

Answer |>
  view()
