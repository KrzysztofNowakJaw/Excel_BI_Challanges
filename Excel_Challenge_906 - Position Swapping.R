#https://www.linkedin.com/posts/excelbi_excel-challenge-problem-activity-7424663118271700993-sqzW?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0

library(EBI)
library(tidyverse)

df <- Excel_Bi_File(from = "A1", to = "A10")

Reverse <- function(x) {
  x <- str_split_1(x, pattern = "")

  Numbers_Positions <- which(str_detect(x, '\\d+'))
  Char_Positions <- which(str_detect(x, '[^\\d+]'))

  Rev_N_Pos <- sort(Numbers_Positions, decreasing = TRUE)
  Char_N_Pos <- sort(Char_Positions, decreasing = TRUE)

  x[Numbers_Positions] <- x[Rev_N_Pos]
  x[Char_Positions] <- x[Char_N_Pos]

  Result <- paste(x, collapse = "")

  return(Result)
}


Answer <- df |>
  mutate(Answer = map_chr(String, Reverse)) |>
  view()
