# Link to challange
# https://www.linkedin.com/posts/excelbi_excel-challenge-problem-activity-7265574752092626944-RQ0J?utm_source=share&utm_medium=member_desktop

library(tidyverse)
library(readxl)
library(tidytext)

Pattern <- "[\\d+\\.,\\(\\)-]+"
PatternNegation <- "[^[\\d+\\.,\\(\\)-]+]"
SurroundedBrackets <- "\\(.+\\)"

str_view(df$Strings, PatternNegation)

Transposed <- df |>
  unnest_regex(
    input = Strings,
    output = Split,
    pattern = PatternNegation,
    drop = FALSE
  ) |>
  mutate(
    Split = case_when(
      str_detect(Split, SurroundedBrackets) ~
        paste0("-", str_remove_all(Split, "[\\(\\)]")),
      .default = Split
    )
  ) |>
  mutate(Index = row_number(), .by = Strings) |>
  pivot_wider(id_cols = Strings, names_from = Index, values_from = Split)

Answer <- df |>
  left_join(Transposed)

Answer
