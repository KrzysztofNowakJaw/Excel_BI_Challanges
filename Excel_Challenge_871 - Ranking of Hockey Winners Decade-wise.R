#https://www.linkedin.com/posts/excelbi_excel-challenge-problem-activity-7406905988022222848-8PG9?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0
library(tidyverse)
library(readxl)

df <- read_xlsx(
  "Excel_Challenge_871 - Ranking of Hockey Winners Decade-wise.xlsx",
  range = "A2:D90"
)

Expected <- read_xlsx(
  "Excel_Challenge_871 - Ranking of Hockey Winners Decade-wise.xlsx",
  range = "F2:I13"
)

Pivoted <- df |>
  pivot_longer(2:ncol(df)) |>
  mutate(
    Points = case_when(name == "Gold" ~ 3, name == "Silver" ~ 2, .default = 1)
  )

Calendar <- data.frame(
  Year = seq(
    from = min(df$Year),
    to = RoundTo(max(df$Year), multiple = 10, FUN = ceiling) - 1,
    by = 1
  )
) |>
  mutate(Decade = cumsum(Year %% 10 == 0))


Answer <- Calendar |>
  left_join(Pivoted) |>
  mutate(Points = replace_na(Points, 0)) |>
  mutate(Min = min(Year), Max = max(Year), .by = Decade) |>
  unite("Decade", Min:Max, sep = "-") |>
  summarise(Points = sum(Points), .by = c(Decade, value)) |>
  mutate(Rank = dense_rank(desc(Points)), .by = Decade) |>
  filter(Rank < 4) |>
  arrange(Decade, Rank, value) |>
  mutate(value = paste(value, collapse = ", "), .by = c(Decade, Rank)) |>
  unique() |>
  pivot_wider(
    id_cols = Decade,
    names_from = Rank,
    names_prefix = "Rank",
    values_from = value
  ) |>
  view()

all.equal(Answer, Expected, check.class = FALSE)
