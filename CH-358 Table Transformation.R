#https://docs.google.com/spreadsheets/d/1Yz5Bj5gIxQVkPTTMq9DhODa6vs3YjrKf/edit?gid=978478387#gid=978478387
library(tidyverse)
library(tidyselect)
library(readr)
library(janitor)

df <- read_xlsx(File_name, range = "B3:E17")

df <- df |>
  replace_na(list(Column1 = "Date")) |>
  mutate(Index = cumsum(Column1 == "Date"), .before = 1) |>
  mutate(across(everything(), \(x) replace_na(x, "0")))

Indexed <- df |>
  select(!contains("Index")) |>
  split(df$Index)

Header_Sort <- function(tab) {
  SelectVar <- tab |>
    as.data.frame()

  SelectVar <- SelectVar[, colSums(SelectVar != 0) > 0]

  SelectVar |>
    row_to_names(1) |>
    select(sort(peek_vars())) |>
    relocate(Date, 1) |>
    mutate(Date = excel_numeric_to_date(as.numeric(Date)))
}

Combined <- map_dfr(Indexed, Header_Sort)

Answer <- Combined |>
  pivot_longer(2:ncol(Combined)) |>
  mutate(value = as.numeric(value)) |>
  replace_na(list(value = 0)) |>
  summarise(value = sum(value), .by = c(Date, name)) |>
  pivot_wider(id_cols = Date, names_from = name, values_from = value)

Answer |>
  view()
