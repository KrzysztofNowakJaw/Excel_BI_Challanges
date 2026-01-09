#https://www.linkedin.com/posts/excelbi_excel-challenge-problem-activity-7415240949108482048-WWAk?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0

library(tidyverse)
library(readxl)

df <- read_xlsx(File_name) |> janitor::clean_names()

Is_Jolly <- function(x) {
  Vector <- str_split_1(x, ", ") |> as.numeric()

  N_Minus_1 <- length(Vector) - 1

  Abs_Diff <- sort(abs(diff(Vector)))

  Result <- all(1:N_Minus_1 == Abs_Diff)

  if (Result == TRUE) {
    "Jolly"
  } else {
    "Not jolly"
  }
}

df |>
  mutate(My_Answer = map_chr(input_string, Is_Jolly)) |>
  mutate(Test = answer_expected == My_Answer) |>
  view()
