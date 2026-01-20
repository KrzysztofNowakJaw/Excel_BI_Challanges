library(tidyverse)
library(readxl)
library(gt)

df <- read_xlsx("Excel_Challenge_895 - Max Sales.xlsx", range = "A2:F51")

Answer <- df |>
  mutate(
    Quarter = paste(
      quarter(Date),
      year(Date),
      sep = "-"
    )
  ) |>
  summarise(Amount = sum(Price * Units), .by = c(SalesRep, Quarter)) |>
  slice_max(order_by = Amount, n = 1, by = Quarter, with_ties = TRUE) |>
  reframe(Name = paste(SalesRep, collapse = ", "), .by = Quarter, Amount) |>
  unique() |>
  mutate(Quarter = paste0("Q", Quarter))


Answer |>
  gt(rowname_col = "Quarter") |>
  tab_stubhead(label = "Quarter") |>
  tab_style(
    style = cell_fill(color = "gray95"),
    locations = cells_stub()
  ) |>
  tab_header(
    title = "EXCEL CHALLENGE 895",
    subtitle = "Sales representative with the highest amount per quarter"
  ) |>
  gt::fmt_currency(columns = Amount) |>
  gt::tab_footnote(footnote = "Source: linkedin.com/in/excelbi/")

Ex <- read_xlsx("Excel_Challenge_895 - Max Sales.xlsx", range = "H2:J9")
