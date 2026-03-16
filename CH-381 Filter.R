#https://docs.google.com/spreadsheets/d/1BJGHoAtWbu7WFCuJyQP9d8ygJnYfa3g0/edit?gid=1625273599#gid=1625273599
library(tidyverse)

df <- tibble(
  ID = c("MN1234", "AB5678", "XY2468", "PQ1357", "LM1023", "GH9087", "ST2467")
)


Alteration <- function(x) {
  tibble(Values = str_extract_all(x, '\\d{1}')) |>
    unnest(everything()) |>
    mutate(
      IsOdd = consecutive_id(
        as.numeric(Values) %% 2 == 0
      )
    ) |>
    reframe(Test = max(IsOdd) >= 3) |>
    pull(Test)
}

df$ID |> keep(Alteration)
