#https://lnkd.in/p/drRvnYbF
library(tidyverse)

df <- data.frame(
  Number = c(145, 40585, 1, 2, 123, 120, 9999)
) |>
  mutate(Number = as.character(Number))


Is_factorial <- function(x) {
  Split <- str_split_1(x, pattern = "") |> as.numeric()

  Sums_f <- map_dbl(Split, \(x) factorial(x)) |> sum()

  Result <- x == Sums_f

  return(Result)
}

df |>
  mutate(Answer = map_lgl(Number, Is_factorial))
