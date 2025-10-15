#https://www.linkedin.com/posts/excelbi_excel-challenge-problem-activity-7384075300533465088-SinT?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0

library(tidyverse)
df <- read_xlsx(File_name, range = "A1:E19")

pivoted <- df |>
  pivot_longer(everything()) |>
  arrange(name, value) |>
  filter(!is.na(value))

pivoted$value <- sort(pivoted$value)

PivotedLen <- pivoted |>
  mutate(CLenght = n(), .by = name) |>
  mutate(Max = max(CLenght))

Lists <- pivoted |>
  pivot_wider(names_from = name, values_from = value, values_fn = list)


AlignList <- function(x) {
  x <- x[[1]]
  TotalLenght <- PivotedLen$Max[1]

  return
  c(x, rep(NA, TotalLenght - length(x)))
}

Answer <- apply(Lists, 2, AlignList) |> as.data.frame()

view(Answer)
