#https://docs.google.com/spreadsheets/d/14ATVpKMg5v-kazKWkyUTBI79NIoyde-2/edit?gid=1757649619#gid=1757649619

library(tidyverse)
library(slider)

IDs <- slide(
  df$ID,
  .after = 1,
  .f = function(x) {
    paste(x, collapse = ",")
  },
  .complete = FALSE
)


Sales <- slide(
  df$Sales,
  .after = 1,
  .f = sum,
  .complete = FALSE
)

df$IDs <- unlist(IDs, recursive = TRUE, use.names = FALSE)
df$Sales <- unlist(Sales, recursive = TRUE, use.names = FALSE)

df |>
  select(IDs, Sales) |>
  view()
