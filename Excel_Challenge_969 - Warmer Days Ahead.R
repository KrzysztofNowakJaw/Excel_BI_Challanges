#https://www.linkedin.com/posts/excelbi_excel-challenge-problem-activity-7456915521616134144-UAJ_?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0

library(tidyverse)
library(readxl)

df <- read_xlsx(File_name, range = "A1:B21")
Ex <- read_xlsx(File_name, range = "C1:C21")

df$Result <-
  map_dbl(1:nrow(df), function(x) {
    First_Bigger <- which(df$Temperature[x] < df$Temperature[(x + 1):nrow(df)])

    if (length(First_Bigger) == 0) {
      0
    } else {
      min(First_Bigger)
    }
  })

df |>
  view()

Ex$`Answer Expected` == df$Result
