# https://www.linkedin.com/posts/omidmot_exclude-powerabrquery-excel-activity-7380708369826947073-pypU?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0
library(tidyverse)

df <- data.frame(Question = c(
  8,
  5,
  3,
  6,
  4,
  7,
  3,
  1,
  9
)) |>
  mutate(Index = row_number(), .before = Question)


df |>
  left_join(df, join_by(Index < Index)) |>
  filter((Question.x < Question.y) & (Question.x + Question.y >= 12)) |>
  mutate(Answer = paste(Question.x, Question.y, sep = ","), .keep = "none")
