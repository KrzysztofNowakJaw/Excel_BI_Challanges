#https://www.linkedin.com/posts/excelbi_excel-challenge-problem-activity-7371392002002759680-i0Vh?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0

library(tidyverse)


df <- read_xlsx(File_name, range = "A2:B7")
Expected <- read_xlsx(File_name, range = "D2:F20")

Answer <- df |>
  mutate(Data = str_remove_all(Data, "[\t\\s]")) |>
  separate_longer_delim(Data, ";") |>
  separate_longer_delim(Data, delim = ",") |>
  mutate(
    Seq = str_extract_all(Data, "[\\d]+"),
    Data = str_remove_all(Data, "[\\d+:]"),
    Data = na_if(Data, "")
  ) |>
  fill(Data, .direction = "down") |>
  unnest_longer(Seq) |>
  arrange(as.numeric(Seq)) |>
  rename(Name = Data) |>
  select(Name, Seq, State)

Answer
