#link
#https://www.linkedin.com/posts/omidmot_powerabrquery-excel-powerabrqueryabrtips-activity-7310405144913854464-aMCY?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0

library(tidyverse)

text <- c("International Business Machines",
          "Central Processing Unit",
          "Artificial Intelligence",
          "Power Query",
          "Power BI")

df <- data.frame(Text = text)

Answer <- df |>
  group_by(Original = Text) |>
  separate_longer_delim(cols = Text,delim = ' ') |>
  mutate(FirstLetter = str_extract(Text,"^.")) |>
  ungroup() |>
  summarise(Answer = paste(FirstLetter,collapse = ''),.by = Original)

Answer
