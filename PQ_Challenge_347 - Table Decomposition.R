library(readr)
library(tidyverse)
library(gt)
library(janitor)

Main <- read_xlsx(File_name, range = "A1:F6") |> clean_names()

Sub <- read_xlsx(File_name, range = "A8:B11") |> clean_names()

Base_Table <- Main |>
  mutate(MainIndex = row_number(), .before = 1) |>
  cross_join(Sub) |>
  mutate(
    Index = as.character(row_number()),
    .by = activity_name,
    Total_W = quantity * unit_weight * percent,
    ActivityID = paste(
      sub_table,
      paste("ID", as.character(MainIndex), sep = ""),
      sep = "_"
    ),
    .before = 1
  ) |>
  arrange(Index) |>
  select(-c(names(Sub))) |>
  relocate(Total_W, .after = chainage) |>
  mutate(across(!contains("Total_W"), as.character))

SubTotals <- Base_Table |>
  select(!contains("Index")) |>
  split(Base_Table$Index) |>
  adorn_totals(name = "TOTAL") |>
  bind_rows()

GlobalTotal <- Base_Table |>
  summarise(Total_W = sum(Total_W, na.rm = TRUE)) |>
  mutate(ActivityID = "GRAND TOTAL", .before = 1)

bind_rows(SubTotals, GlobalTotal) |>
  gt()
