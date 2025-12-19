#https://www.linkedin.com/posts/excelbi_excel-challenge-problem-activity-7407268375825014784-UkwN?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0
library(tidyverse)
library(tidytext)
library(readxl)


df <- read_xlsx(File_name, range = "A1:A50") |>
  mutate(Index = row_number(), .before = 1)

Ex <- read_xlsx(File_name, range = "B1:B50")

Vovels <- '[AaEeIiOoUu]'

Answer <- df |>
  unnest_tokens(
    input = Data,
    output = Data,
    token = "words",
    to_lower = TRUE,
    drop = FALSE
  ) |>
  unnest_characters(input = Data, output = L, to_lower = TRUE, drop = FALSE) |>
  mutate(
    IsV = str_detect(L, Vovels),
    .by = Index
  ) |>
  mutate(VovIndex = row_number(), .by = c(Index, IsV)) |>
  mutate(
    L = case_when(
      VovIndex %% 2 == 0 & IsV == TRUE ~ str_to_upper(L),
      .default = L
    )
  ) |>
  summarise(Answer = paste(L, collapse = ""), .by = c(Index, Data)) |>
  summarise(Answer = paste(Answer, collapse = " "), .by = c(Index))

all.equal(Answer$Answer, Ex$`Answer Expected`, check.attributes = FALSE)

Answer |> view()
