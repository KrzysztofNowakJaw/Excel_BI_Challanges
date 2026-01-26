#https://docs.google.com/spreadsheets/d/14QQB__8LC2ffoq4r-MNOj5xL8H9LFS75/edit?gid=917906719#gid=917906719
library(tidyverse)
library(tidyselect)
library(readr)
library(janitor)

df <- read_xlsx(File_name, range = "B3:F13")

df$Index <- sort(rep(1:(nrow(df) / 2), 2))

Indexed <- df |>
  select(!contains("Index")) |>
  split(df$Index)


Header_Sort <- function(tab) {
  tab |>
    as.data.frame() |>
    row_to_names(1) |>
    select(sort(peek_vars())) |>
    relocate(Date, 1) |>
    mutate(Date = excel_numeric_to_date(as.numeric(Date)))
}

map_dfr(Indexed, Header_Sort) |>
  view()
