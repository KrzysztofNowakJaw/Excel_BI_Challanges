#https://www.linkedin.com/posts/excelbi_excel-challenge-problem-activity-7404369284405354496-TuqP?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0

library(tidyverse)
library(tidytext)

df <- data.frame(
  Data = c(
    "boy",
    "moonlight",
    "bcdxyz",
    "crimsonpeak",
    "queueing",
    "hypernovablast",
    "aeiou",
    "bluedragonfly",
    "zbstquiousneee",
    "starforgeempire"
  ),
  stringsAsFactors = FALSE
)


Vovels <- '[AaEeIiOoUu]'

Answer <- df |>
  unnest_characters(input = Data, output = L, to_lower = FALSE, drop = FALSE) |>
  mutate(
    Index = consecutive_id(str_detect(L, pattern = Vovels)),
    .by = Data
  ) |>
  mutate(
    Count = n(),
    LastPosition = row_number(),
    L = case_when(
      LastPosition == Count ~ paste(L, "-", sep = ""),
      .default = L
    ),
    .by = c(Data, Index)
  ) |>
  summarise(
    Answer = str_remove(
      paste(L, collapse = ""),
      pattern = "-$"
    ),
    .by = Data
  ) |>
  view()

Expected$Answer == Answer$Answer
