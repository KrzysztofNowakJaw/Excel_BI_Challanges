#Source
#https://www.linkedin.com/posts/excelbi_challenge-powerquerychallenge-daxchallenge-activity-7303987854601265152-4pfX?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0
library(tidyverse)

#Numbers to replicate
My_List <- seq(from = 2,to = 10,by = 1)

#replicate group by its lenght
Groups <- sapply(My_List, function(x) { rep(x,x) }) |> unlist() 

#sort groups
Groups <- sort(Groups,decreasing = TRUE)

#rows without groups
Difference <- nrow(df) - length(Groups)
OneRowGroups <- seq(from = 11,to = 10 + Difference,by = 1)

#create column with group
df$Group <- c(Groups,OneRowGroups)

#running total
Answer <- df |>
  mutate(Running = cumsum(Amount),.by = Group)
#compare with expected
Answer$Test <- Answer$Running == expected$Amount
Answer
