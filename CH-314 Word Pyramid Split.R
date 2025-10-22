#https://docs.google.com/spreadsheets/d/1JqjBO8KKhxzwDt9Ld2U0TbZrIrq0Hazy/edit?gid=979051708#gid=979051708
library(tidyverse)
library(readr)
library(gt)

df <- read_xlsx(File_name, range = "B1:B7")

SplitMerge <- function(x) {
  Alpha <- str_split(x, pattern = "")[[1]]
  Concat <- accumulate(Alpha, paste)
  Concat <- paste(Concat, collapse = " | ")

  return(Concat)
}


df |>
  mutate(Answer = map_chr(Question, SplitMerge)) |>
  gt()
