#https://www.linkedin.com/posts/omidmot_exclude-powerabrquery-excel-activity-7435428954305413121-eyIt?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0

library(tidyverse)

ids <- c("MN12Q43", "AB13562", "X13Y248", "PQ78913", "LM1423", "GH5678", "ST2467")

df <- data.frame(ID = ids)

Check_Conditions <- function(x) {

Odd <- '[13579]'
Even <- '[2468]'

Sum_Odd <- str_extract_all(x,Odd)[[1]] |> as.numeric() |> sum()
Sum_Even <- str_extract_all(x,Even)[[1]] |> as.numeric() |> sum()

Result <- sum(Sum_Odd > 10,Sum_Even < 10) == 1

return(Result)

}

My_result <- df$ID |>
  keep(Check_Conditions)

My_result

