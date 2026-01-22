#https://docs.google.com/spreadsheets/d/1V7ia9vOIrE9BGawX-U4Jz3U340gJ0457/edit?gid=1598014848#gid=1598014848
library(janitor)
library(readxl)
library(tidyverse)

df <- read_xlsx(File_name, range = "B3:B18")

Categories <- df |>
  mutate(
    Group = case_when(
      str_detect(Name, '\\d+\\.\\d+') ~ 1,
      str_detect(Name, '[A-Z]') ~ 2,
      .default = 3
    )
  )

Binded <- Categories |>
  split(Categories$Group) |>
  bind_cols() |>
  select(contains("Name"))

names(Binded) <- c('Date', 'Product', 'Sale')

Answer <- Binded |>
  mutate(Date = excel_numeric_to_date(as.numeric(Date)))

Answer
