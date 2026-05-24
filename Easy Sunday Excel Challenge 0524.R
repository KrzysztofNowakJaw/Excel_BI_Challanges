#https://www.linkedin.com/posts/crispo-mwangi-6ab49453_easy-sunday-excel-challenge-return-activity-7464163272410243073-KyJ2?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0

library(tidyverse)

slowa <- c(
  "dashboard",
  "assessment",
  "analytics",
  "redder",
  "mississippi",
  "developed",
  "statistics",
  "tartar"
)

df <- data.frame(ID = slowa)

First_Unique <- function(x) {
  Split <- str_split_1(x, "")

  Positions <- which(Split %in% names(which(table(Split) == 1)))

  if (length(Positions) == 0) " " else Split[min(Positions)]
}

df |>
  mutate(Answer = map_chr(ID, First_Unique)) |>
  view()
