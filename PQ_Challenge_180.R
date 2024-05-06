#LinkToChallange
#https://www.linkedin.com/posts/excelbi_challenge-powerquerychallenge-daxchallenge-activity-7192734760387960832-6Zh_?utm_source=share&utm_medium=member_desktop

library(tidyverse)
library(readxl)

filename <- "PQ_Challenge_180.xlsx"

df <- read_xlsx(filename, range = "A1:B28") |> janitor::clean_names()

Calendar <- seq.Date(from = Sys.Date(), to = Sys.Date() + 365,by = "month") |>
  as.tibble() |>
  mutate(Month = format(value,"%b")) |>
  select(Month) |>
  unique() |>
  pull()

Cleaned <- df |>
  mutate(Month = if_else(emp_month %in% Calendar,emp_month,NA),
         Name = if_else(is.na(Month),emp_month,NA),
         sales = coalesce(sales,0)) |>
  fill(Name,.direction = "down") 

Total <- Cleaned |>
  summarise(TotalSales = sum(sales),.by = "Name")

Sales <- Cleaned |>
  group_by(Name) |>
  mutate(MaxDifference = abs(coalesce(sales - lag(sales),0))) |>
  ungroup() |>
  slice_max(order_by = MaxDifference,n = 1,by = Name) |>
  mutate(Previous = format(
    floor_date(ymd(paste("2024",Month,"01",sep = "-")),unit = "month")-1,"%b"),
    ,From_To_Months = paste(Previous,Month,sep = "-")) |>
  select(Name,From_To_Months,MaxDifference) 

Answer <- merge(Total,Sales)

Answer
