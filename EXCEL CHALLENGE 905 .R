#https://www.linkedin.com/posts/excelbi_excel-challenge-problem-activity-7424300710856687617-5lUZ?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0

library(EBI)
library(tidyverse)

df <- Excel_Bi_File(from = "A2", to = "D52")

Answer <- df |>
  slice_max(
    n = 1,
    order_by = `Listed Price`,
    with_ties = TRUE,
    by = c(Zone, Type)
  ) |>
  summarise(
    Combine = paste(`House ID`, collapse = ", "),
    .by = c(Zone, Type)
  ) |>
  arrange(Zone, Type) |>
  pivot_wider(id_cols = Zone, names_from = Type, values_from = Combine)

Answer
