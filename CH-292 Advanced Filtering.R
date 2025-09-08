library(tidyverse)
df <- read_xlsx(File_name,range = "B2:E9")

df |>
  rowwise() |>
  mutate(Test = list(unique(c_across(2:ncol(df))))) |>
  filter(length(Test) == ncol(df)-1) |>
  pull(ID)




