#https://docs.google.com/spreadsheets/d/1Kdi49Ice4WwqiOIxZ7dhokYvxYkDgJRG/edit?gid=1995925256#gid=1995925256

library(tidyverse)
library(readxl)

df <- read_xlsx(File_name, range = "B2", col_names = c("Question"))

Split <- df |>
  mutate(
    Question = str_replace_all(
      Question,
      pattern = "\\t|\\r|\\n",
      replacement = " "
    )
  ) |>
  separate_longer_delim(Question, " ")

Split |>
  slice(6:nrow(Split)) |>
  filter_out(Question == "") |>
  mutate(Names = rep(Split$Question[1:4], length(unique(Groups$Group)))) |>
  pivot_wider(names_from = Names, values_from = Question, values_fn = list) |>
  unnest(everything()) |>
  view()
