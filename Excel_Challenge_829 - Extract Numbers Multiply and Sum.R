#https://www.linkedin.com/posts/excelbi_excel-challenge-problem-activity-7385887496615825408-Bv2f?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0
library(tidyverse)
library(readr)

df <- read_xlsx(File_name, range = "A1:B10")

MultiplyNumbers <- function(x) {
  Numbers <- str_extract_all(x, '\\d+')[[1]]

  if (length(Numbers) %% 2 == 0) {
    Numbers
  } else {
    Numbers <- c(Numbers, "1")
  }

  Index <- 1:(length(Numbers) / 2)

  Index <- sort(rep(Index, 2))

  Multiply <- tibble(Values = as.numeric(Numbers)) |>
    mutate(Group = Index) |>
    group_by(Group) |>
    mutate(Result = Values * lag(Values, default = 0)) |>
    ungroup() |>
    reframe(Result = sum(Result)) |>
    pull(Result)

  return(Multiply)
}

df |>
  mutate(
    My_Answer = map_int(Strings, MultiplyNumbers),
    Test = `Answer Expected` == My_Answer
  )
