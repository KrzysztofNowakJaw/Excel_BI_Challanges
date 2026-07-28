# Read the Excel file
#https://docs.google.com/spreadsheets/d/1rtJI9UDOXRBXJxWEfWlrKzuLttIWY_Jl/edit?gid=417397307#gid=417397307
library(tidyverse)
library(zoo)

df <- read_xlsx(
  File_name,
  range = "B3:D10",
  col_types = c("date", "text", "numeric")
)

Answer <- df |>
  group_split(Product) |>
  map(\(df) {
    df_zoo <- zoo(df$Sales, order.by = df$Date)
    Mean <- rollapply(df_zoo, 3, mean, align = "left")[[1]]
    df |> filter(Sales > Mean)
  }) |>
  bind_rows()

Answer |> view()
