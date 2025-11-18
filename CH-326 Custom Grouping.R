#Link
#https://docs.google.com/spreadsheets/d/1b3h40maRDY8_XWGYB4WcR0GNRPvfLaLL/edit?gid=339030944#gid=339030944
#libraries
library(tidyverse)
library(glue)

df <- read_xlsx(File_name, range = "B2:E11") |>
  mutate(Index = row_number(), .before = 1)

df |>
  rowwise() |>
  mutate(
    Combine1 = paste(sort(c(From, To)), collapse = ""),
    Combine2 = paste(sort(c(From, To), decreasing = TRUE), collapse = "")
  ) |>
  unite("Group", Combine1:Combine2, sep = " or ") |>
  summarise(`Total Sales` = sum(Sales), .by = Group) |>
  view()
