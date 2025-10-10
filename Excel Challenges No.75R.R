# link to challenge
# https://www.linkedin.com/posts/omid-motamedisedeh-74aba166_excelchallenge-powerquerychllenge-excel-activity-7212922787689058305-dtFa?utm_source=share&utm_medium=member_desktop
library(readxl)

filename <- "CH-75 Table Transformation.xlsx"

df <- read_xlsx(filename, range = "B2:E20") |> mutate(Date = as.Date(Date))

Answer <- df |>
       group_by(Product, `Order ID`) |>
       mutate(
              BaseDate = min(Date),
              Difference = case_when(
                     Quantity < 0 ~ as.numeric(Date - BaseDate),
                     .default = NA
              )
       ) |>
       filter(!is.na(Difference)) |>
       group_by(Product) |>
       mutate(
              Total = sum(abs(Quantity)),
              SubTotal = sum(Difference * abs(Quantity)),
              Result = round(SubTotal / Total, 2),
              Result = sprintf("%.2f", Result)
       ) |>
       ungroup() |>
       slice_head(n = 1, by = Product) |>
       select(Product, Result) |>
       arrange(Product)

Answer
