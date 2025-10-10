# link to challange Power Query Challenges No.107
# https://www.linkedin.com/posts/omid-motamedisedeh-74aba166_powerabrquery-excel-powerabrqueryabrtips-activity-7236478000156811264-ezfw?utm_source=share&utm_medium=member_desktop
library(tidyverse)
library(readxl)


Expert <- read_xlsx("CH-107 Matching Tables.xlsx", range = c("B2:C9"))
Manager <- read_xlsx("CH-107 Matching Tables.xlsx", range = c("E2:F9"))


Expert <- Expert |> mutate(Category = "Expert")
Manager <- Manager |> mutate(Category = "Manager")

Combined <- bind_rows(Expert, Manager)

Combined$Category <- factor(
  Combined$Category,
  levels = c("Manager", "Expert"),
  labels = c(1, 2),
  ordered = TRUE
)

Answer <- Combined |>
  na.omit() |>
  mutate(QNR = as.numeric(str_extract(`Question ID`, "\\d+$"))) |>
  arrange(QNR) |>
  slice_min(order_by = Category, n = 1, by = `Question ID`) |>
  complete(QNR = seq(from = min(QNR), to = max(QNR), by = 1)) |>
  mutate(
    `Question ID` = case_when(
      is.na(`Question ID`) ~ paste('Q', as.character(QNR), sep = "-"),
      .default = `Question ID`
    )
  ) |>
  select(`Question ID`, Response)


Answer
