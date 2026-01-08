#https://www.linkedin.com/posts/excelbi_excel-challenge-problem-activity-7414878524198625280-nX9j?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0

library(tidyverse)
library(readxl)

df <- read_xlsx(File_name, range = "A2:A22")

Expected <- read_xlsx(File_name, range = "B2:C22")

Min_Prod <- function(x) {
  x <- str_split_1(x, ", ")

  Combinations_Table <- t(combn(x, 3)) |> as.tibble()

  Products <- Combinations_Table |>
    rowwise() |>
    mutate(across(everything(), \(x) as.numeric(x))) |>
    mutate(Multiply = prod(c_across(everything())))

  Products |>
    filter(Multiply == min(Products$Multiply)) |>
    unite("Answer", 1:3, sep = ",") |>
    mutate(Answer = paste0("(", Answer, ")")) |>
    summarise(Sequence = paste(Answer, collapse = ", "), .by = Multiply)
}

Result <- map_dfr(df$Data, Min_Prod)

df |>
  bind_cols(Result) |>
  view()
