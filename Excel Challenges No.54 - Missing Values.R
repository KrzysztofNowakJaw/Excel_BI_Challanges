#Link to challange
#https://www.linkedin.com/posts/omid-motamedisedeh-74aba166_excelchallenge-powerquerychllenge-excel-activity-7197702500592832512-2OK8?utm_source=share&utm_medium=member_desktop

library(tidyverse)
library(readxl)
library(scales)

filename <- "CH-054 Missing Values.xlsx"

df <- read_xlsx(filename, range = "B2:D21") |> janitor::clean_names()
Expected <- read_xlsx(filename, range = "H2:J38") |> janitor::clean_names()


Answer <- df |>
  mutate(Year = year(date),
         Month = month(date)) |>
  group_by(project, Year) |>
  complete(Month = seq(from = min(Month),
                       to = max(Month))) |>
  arrange(project, Year, Month) |>
  fill(actual_progress, .direction = "down") |>
  mutate(
    date = ymd(paste(Year, Month, "01", sep = "-")),
    date = ceiling_date(date, unit = "month") - 1,
    actual_progress = percent(actual_progress)
  ) |>
  ungroup() |>
  select(date, project, actual_progress)

View(Answer)
