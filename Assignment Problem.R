#LinkToChallange
#https://www.linkedin.com/posts/omid-motamedisedeh-74aba166_excelchallenge-powerquerychllenge-excel-activity-7194078630744842240-MlNb?utm_source=share&utm_medium=member_desktop

library(tidyverse)
library(readxl)

filename <- "CH-049 Assignment Problem Part 1.xlsx"

df <- read_xlsx(filename, range = "B2:F6") 

RowWise <- df |>
  rowwise() |>
  mutate(Lowest = min(c_across(where(is.numeric))),
         across(starts_with("task"),\(x) x - Lowest)) |>
  select(-c(Lowest)) |>
  ungroup()

DeductMin <- function(x) {
  x - min(x) 
}

Step2 <- apply(RowWise[2:ncol(RowWise)],2,DeductMin) |> as_tibble()

Answer <- df |>
  select(1) |>
  bind_cols(Step2)

Answer |>
  gt::gt()
