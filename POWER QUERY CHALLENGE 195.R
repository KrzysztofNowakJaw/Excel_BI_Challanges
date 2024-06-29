# link to challenge
# https://www.linkedin.com/posts/excelbi_challenge-powerquerychallenge-daxchallenge-activity-7212665760391843840-7CLQ?utm_source=share&utm_medium=member_desktop
library(tidyverse)
library(readxl)

filename <- "PQ_Challenge_195.xlsx"

T1 <- read_xlsx(filename, range = "A1:C5")
T2 <- read_xlsx(filename, range = "A8:B11")

Clean <- function(x) {
  Pattern <- "[[:punct:]]\\s?"
  replace_delimiters <- str_replace_all(x, pattern = Pattern, replacement = ".")
  return(replace_delimiters)
}

CleanedT1 <- T1 |>
  mutate(across(all_of(names(T1)), Clean))


CleanedT1 <- CleanedT1 |>
  separate_longer_delim(everything(), ".") |>
  mutate(across(1:3, \(x) trimws(x)))

T2 |>
  separate_longer_delim(Items, ", ") |>
  left_join(CleanedT1) |>
  mutate(
    N = n_distinct(Stockist),
    .by = Items, Stockist
  ) |>
  mutate(across(3:4, \(x) ifelse(is.na(x), 0, x)),
    Total = as.numeric(`Unit Price`) * as.numeric(Quantity) / N
  ) |>
  summarise(Result = sum(Total), .by = Stockist)
