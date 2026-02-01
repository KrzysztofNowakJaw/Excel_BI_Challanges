library(EBI)
library(tidyverse)
library(gt)

df <- Excel_Bi_File(from = "A1", to = "C51")

Scores <- df |>
  select(-Date) |>
  separate_longer_delim(c(Teams, Score), delim = "-")

Scores$Group <- sort(rep(1:(nrow(Scores) / 2), 2))

Scores <- Scores |>
  mutate(Match_Index = row_number(), .by = Group)

Scores$GA <-
  Scores |>
  arrange(Group, desc(Match_Index)) |>
  select(GA = Score) |>
  pull(GA)


Answer <- Scores |>
  mutate(across(-Teams, as.numeric)) |>
  summarise(
    Played = n(),
    Won = sum(GA < Score),
    Drawn = sum(GA == Score),
    Lost = sum(GA > Score),
    GF = sum(Score),
    GA = sum(GA),
    .by = Teams
  ) |>
  mutate(
    Points = Won * 3 + Drawn
  )

Answer |>
  gt()
