#https://www.linkedin.com/posts/omidmot_exclude-powerabrquery-excel-activity-7408974625378013185-zoOF?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0

library(tidyverse)

df <- data.frame(
  Pattern = c(
    "++-+++-+++-",
    "++++++++",
    "+-+-+-+-+",
    "++++-----",
    "+-+"
  ),
  stringsAsFactors = FALSE
)


CountChange <- function(x) {
  tibble(Signs = str_split_1(x, pattern = "")) |>
    summarise(Change = max(consecutive_id(Signs)) - 1) |>
    pull(Change)
}

df |>
  mutate(Count = map(Pattern, CountChange))
