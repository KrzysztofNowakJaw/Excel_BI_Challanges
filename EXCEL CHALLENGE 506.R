#Link to challenge
#https://www.linkedin.com/posts/excelbi_excel-challenge-problem-activity-7221728409410842624-hFYz?utm_source=share&utm_medium=member_desktop

# Load necessary libraries for data manipulation and reading Excel files
library(tidyverse)
library(readxl)

# Define the filename of the Excel file containing the grid data
filename <- 'Excel_Challenge_506 - Align Concated Alphabets & Numbers.xlsx'

T1 <- read_xlsx(filename, range = 'A1:B6')
Expected <- read_xlsx(filename, range = 'C1:C22')


Sequence <- function(x) {
  Min = as.numeric(str_extract(x, '^\\d+'))
  Max = as.numeric(str_extract(x, '\\d+$'))
  Result <- seq(from = Min, to = Max, by = 1)
  return(Result)
}

Answer <- T1 |>
  separate_longer_delim(cols = Numbers, delim = ', ') |>
  mutate(Numbers = map(Numbers, Sequence)) |>
  unnest_longer(Numbers) |>
  mutate(Index = row_number(), .by = c(Alphabets)) |>
  mutate(`Expected Answer` = str_c(Alphabets, as.character(Numbers))) |>
  arrange(Index) |>
  select(`Expected Answer`)

Answer
all.equal(Answer, Expected)
