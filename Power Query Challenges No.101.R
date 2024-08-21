#link to challenge
#https://www.linkedin.com/posts/omid-motamedisedeh-74aba166_powerabrquery-excel-powerabrqueryabrtips-activity-7232129349246722048-j_1F?utm_source=share&utm_medium=member_desktop

library(tidyverse)
library(gtools)

df <- data.frame(
  ID = 1:5,
  value = c(2, 3, 5, 7, 11)
)

Combinations <- combinations(v = df$ID,r = 3,n = 5)

Table <- as.data.frame(Combinations)

Answer <- Table |>
  mutate(Index = row_number(),.before = V1) |>
  pivot_longer(cols = -c(Index),values_to = "ID") |>
  left_join(df,by = "ID") |>
  summarise(`ID Combination` = paste(ID,collapse = ","),
            `Total value (cost)` = sum(value)
            ,.by = Index)


Answer
?combinations
