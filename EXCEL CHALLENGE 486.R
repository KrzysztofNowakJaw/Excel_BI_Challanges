#Link to challange
#https://www.linkedin.com/posts/excelbi_excel-challenge-problem-activity-7211578968074797057-Y1X4?utm_source=share&utm_medium=member_desktop

library(tidyverse)
library(readxl)

filename <- "Excel_Challenge_486 - Create Integer Intervals.xlsx"

df <- read_xlsx(filename, range = "A1:A8")

Expected <- read_xlsx(filename, range = "B1:B8")

Sequences <- function(x) {
  y <- as.numeric(str_split(x, ", ")[[1]])

  Break <- which(diff(y) > 1)

  Breaks <- tibble(B = Break)

  Combined <- tibble(Values = y) |>
    mutate(Index = row_number()) |>
    left_join(Breaks, join_by(closest(Index > B))) |>
    mutate(Group = consecutive_id(B)) |>
    summarise(Min = min(Values), Max = max(Values), .by = Group) |>
    mutate(Combined = ifelse(Min == Max, Min, str_c(Min, Max, sep = "-")))

  Result <- paste(Combined$Combined, collapse = ", ")

  return(Result)
}


Answer <- df |>
  mutate(Answer = map_chr(Problem, Sequences))

Answer

all.equal(Answer$Answer, Expected$`Answer Expected`)
