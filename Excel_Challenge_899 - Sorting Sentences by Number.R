#https://www.linkedin.com/posts/excelbi_excel-challenge-problem-activity-7421401542420844544-kC37?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0

library(tidyverse)
library(readr)
library(tidytext)


df <- read_xlsx(File_name) |>
  janitor::clean_names() |>
  select(1) |>
  mutate(Index = row_number(), .before = 1)

Result <- df |>
  mutate(Index = row_number(), .before = 1) |>
  unnest_tokens(
    input = input_sentence,
    output = Words,
    token = "words",
    to_lower = FALSE,
    drop = FALSE
  ) |>
  group_by(Index) |>
  mutate(
    Order = str_extract(
      Words,
      pattern = "\\d+"
    )
  ) |>
  arrange(as.numeric(Order)) |>
  summarise(Answer = paste(Words, collapse = " ")) |>
  mutate(Answer = str_remove_all(Answer, pattern = "\\d+"))

Result |> view()


Result$Answer == Ex$answer_expected
