#https://www.linkedin.com/posts/omidmot_exclude-powerabrquery-excel-share-7448941238856351744-4jqt/?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0
library(tidyverse)
library(tidytext)

df <- data.frame(
  question = c(135, 518, 175, 5187, 462, 9474, 4387)
)

df |>
  mutate(question = as.character(question)) |>
  unnest_character_shingles(
    input = question,
    output = Single,
    n = 1,
    strip_non_alphanum = FALSE,
    drop = FALSE
  ) |>
  mutate(Index = row_number(), .by = question, .before = 1) |>
  mutate(Power = as.numeric(Single)^Index) |>
  summarise(Power = sum(Power), .by = question) |>
  mutate(Answer = Power == question) |>
  view()
