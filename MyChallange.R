library(tidyverse)


df <- tibble(
  Column1 = c("cat", "dog", "bird", "fish", "horse"),
  Column2 = c("red", "blue", "green", "yellow", "black"),
  Column3 = c("house", "forest", "city", "river", "mountain"),
  Column4 = c("fast", "slow", "tall", "short", "strong"),
  Column5 = c("read", "write", "run", "swim", "jump")
)

df

RM <- df |>
  rowwise() |>
  mutate(across(everything(), \(x) str_count(x, '.{1}'))) |>
  rowMeans()

Order <- tibble(Cols = names(df), Mean = RM) |>
  arrange(desc(Mean)) |>
  pull(Cols)

select(df, all_of(Order))
