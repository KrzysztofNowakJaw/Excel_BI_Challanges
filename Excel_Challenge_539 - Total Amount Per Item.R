# link to challange Power Query Challenges No.107
# https://www.linkedin.com/posts/excelbi_excel-challenge-problem-activity-7238758032132714496-0XXU?utm_source=share&utm_medium=member_desktop
library(tidyverse)
library(scales)
library(readxl)

T1 <- read_xlsx(
  "Excel_Challenge_539 - Total Amount Per Item.xlsx",
  range = c("A2:F11")
)
T2 <- read_xlsx(
  "Excel_Challenge_539 - Total Amount Per Item.xlsx",
  range = c("H2:J10")
)

LM <- T1 |>
  pivot_longer(cols = 3:ncol(T1), names_to = "Ranges", values_to = "Prices") |>
  separate(col = Ranges, into = c("Low", "Max"), sep = "-") |>
  mutate(
    Low = as.numeric(str_extract(Low, "\\d+")),
    Max = if_else(is.na(Max), Inf, as.numeric(Max))
  )


Answer <- T2 |>
  left_join(LM, join_by(Item == Item, between(Quantity, Low, Max))) |>
  select(Item, Quantity, Prices) |>
  summarise(Average = mean(Prices), .by = c(Item, Quantity)) |>
  mutate(
    Answer = scales::comma(
      Average * Quantity,
      big.mark = "",
      decimal.mark = ","
    )
  ) |>
  select(-c(Average))

Answer
