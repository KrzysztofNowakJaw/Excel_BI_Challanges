# link to challenge
# https://www.linkedin.com/posts/excelbi_excel-challenge-problem-activity-7213390875882602498-SzOL?utm_source=share&utm_medium=member_desktop
library(tidyverse)
library(readxl)

filename <- "Excel_Challenge_489 - Total Time in a Week.xlsx"

T1 <- read_xlsx(filename, range = "A2:H6")

Answer <- T1 |>
  rowwise() |>
  mutate(Names = list(c_across(2:ncol(T1)))) |>
  unnest_longer(Names) |>
  filter(!is.na(Names)) |>
  select(`Time Period`, Names) |>
  separate(`Time Period`, into = c("Beggining", "End"), sep = "-") |>
  mutate(across(c(Beggining, End), ~ hm(.)),
         Duration = End - Beggining) |>
  ungroup() |>
  group_by(Names) |>
  summarize(Sum = sum(as.numeric(Duration))/3600)


Answer
