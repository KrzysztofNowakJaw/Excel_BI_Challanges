#https://www.linkedin.com/posts/excelbi_excel-challenge-problem-activity-7388424225667219456-0Oj7?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0
library(tidyverse)
library(readxl)

df <- read_xlsx('Excel_Challenge_834 - Group Rowwise.xlsx', range = "A2:F10")

OmnitNa <- function(x) {
  result <- paste(intersect(x, LETTERS), collapse = "")
  return(result)
}

Answer <- df |>
  filter(row_number() %% 2 != 0) |>
  rowwise() |>
  mutate(Group = list(paste(c_across(everything())))) |>
  ungroup() |>
  mutate(Group = map_chr(Group, OmnitNa)) |>
  select(Group) |>
  bind_cols(
    df |>
      filter(row_number() %% 2 == 0) |>
      rowwise() |>
      mutate(
        across(everything(), \(x) as.numeric(x)),
        across(everything(), \(x) replace_na(x, 0)),
        Sum = sum(c_across(1:ncol(df)))
      ) |>
      select(Sum)
  )

Answer
