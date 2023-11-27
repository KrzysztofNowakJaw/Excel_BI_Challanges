#Link to challange
#https://www.linkedin.com/feed/update/urn:li:activity:7134752700826595328/

library(tidyverse)
library(readxl) 


df <- read_xlsx("Amicable Numbers.xlsx", range = "A1:B10") |> janitor::clean_names()


proper_divisiors <- function(n) {
  divisors <- 1:(n/2)
  divisors <- divisors[n %% divisors == 0]
  result <- sum(divisors)
  return(result)
}


Answer <- df |>
  rowwise() |>
  mutate(across(everything(),list(C1 = proper_divisiors))) |>
  filter(number_1 == number_2_C1 | number_1_C1 == number_2) |>
  select(!ends_with("C1"))

Answer
