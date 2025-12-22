#https://www.linkedin.com/posts/excelbi_excel-challenge-problem-activity-7408717932949839873-Irdn?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0

library(tidyverse)
library(tidytext)
library(readxl)

Ex <- read_xlsx(File_name, range = "A2:C44") |> select(2:3)

df <- read_xlsx(File_name, range = "A2:A44") |>
  mutate(Index = row_number(), .before = 1)

ValidGroups <- df |>
  unnest_character_shingles(
    input = Data,
    output = L,
    to_lower = TRUE,
    drop = FALSE,
    n = 1
  ) |>
  mutate(Group = consecutive_id(L), .by = Data) |>
  filter(n() >= 2, .by = c(Data, Group)) |>
  summarise(Result = paste(L, collapse = ""), .by = c(Index, Group)) |>
  mutate(Groups_Count = n(), .by = Index) |>
  slice_max(order_by = nchar(Result), n = 1, by = Index, with_ties = TRUE) |>
  summarise(
    Longest_Groups = paste(Result, collapse = ", "),
    .by = c(Index, Groups_Count)
  )


Missing <- anti_join(df |> select(Index), ValidGroups)

Combined <- ValidGroups |>
  bind_rows(
    data.frame(Index = Missing)
  ) |>
  arrange(Index) |>
  replace_na(list(Groups_Count = 0))

Answer <- df |>
  left_join(Combined) |>
  view()
