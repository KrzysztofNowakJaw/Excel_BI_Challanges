#https://www.linkedin.com/posts/excelbi_excel-challenge-problem-activity-7390960925211656192-DGNl?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0

library(tidyverse)
library(readxl)

df <- read_xlsx(
  "Excel_Challenge_839 - List Unique Across Columns.xlsx",
  range = "A1:E9"
)

AlignList <- function(x) {
  x <- x[[1]]
  TotalLenght <- max(Piv_clean$Maxlen)
  return
  c(x, rep(NA, TotalLenght - length(x)))
}

Pivoted <- df |>
  pivot_longer(everything(), values_drop_na = TRUE) |>
  mutate(Index = row_number(), .by = name) |>
  arrange(name, Index)

Pivoted$Is_dup <- duplicated(Pivoted$value)

Piv_clean <- Pivoted |>
  filter(Is_dup == FALSE) |>
  mutate(Maxlen = n(), .by = name)

Clean_listed <- Piv_clean |>
  select(name, value) |>
  pivot_wider(names_from = name, values_from = value)


Answer <- apply(Clean_listed, 2, AlignList) |> as.data.frame()

Answer
