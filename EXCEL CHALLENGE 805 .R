#https://www.linkedin.com/posts/excelbi_excel-challenge-problem-activity-7373566317884411904-Y0Xw?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0

df <- read_xlsx("/Users/krzysztofnowak/Desktop/ExcelBi/Excel_BI_Challanges/Excel_Challenge_805 - Vowels in Increasing or Decreasing Order.xlsx",range = "A2:B16")


library(tidyverse)
library(readxl)


VowelsOrder <- function(word) {

  word <- str_to_lower(word)
  InScope <- str_extract_all(word, "[aeiou]")[[1]] |> unique()

  SumTrue <- sum(
    diff(which(letters %in% InScope)) > 0,
    diff(which(letters %in% InScope)) < 0
  )
  return(SumTrue)
}

df |>
  filter( map_int(.x = Rivers, .f = VowelsOrder) == 1) |>
  group_by(Group) |>
  mutate(Index = paste("River",as.character(row_number()))) |>
  pivot_wider(id_cols = Group,names_from = Index,values_from = Rivers) |>
  arrange(Group)

