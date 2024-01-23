#link to challange:
#https://www.linkedin.com/feed/update/urn:li:activity:7154322067520118784/

library(tidyverse)
library(readxl)
library(openxlsx)

# Read data from Excel file and clean column names
df <- read_xlsx("Power_Query_Challenge_149.xlsx", range = "A1:D6",col_types = c("text","date","date","numeric")) |> janitor::clean_names()

Answer <- df |>
  mutate(Index = row_number(),.before = employee,
         across(ends_with("date"), as.Date)) |>
  pivot_longer(cols = ends_with("date"),names_to = "EndStart",values_to = "Periods") |>
  group_by(Index) |>
  complete(Periods = seq.Date(from = min(Periods),to = max(Periods),by = "day")) |>
  fill(c(employee,per_diem),.direction = "down") |>
  mutate(EoM = ceiling_date(Periods,unit = "month")-1) |>
  group_by(Index,EoM) |>
  mutate(End_Date = max(Periods),
         Start_Date = min(Periods)) |>
  ungroup() |>
  summarise(Days = n(),.by = c(employee,per_diem,EoM,Start_Date,End_Date)) |>
  mutate(Answer = Days * per_diem) |>
  select(employee,Start_Date,End_Date,Answer)


Answer
