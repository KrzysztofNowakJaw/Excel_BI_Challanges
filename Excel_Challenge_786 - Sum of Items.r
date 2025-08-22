#Challange
#https://www.linkedin.com/posts/excelbi_excel-challenge-problem-activity-7363781850340741121-8mL6?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0

library(tidyverse)
library(janitor)

df = read_xlsx(File_name) 

df |>
  separate_longer_delim(Data,delim = ' / ') |>
  mutate(N = as.numeric(str_extract(Data,'\\d+')),
         Data = trimws(str_remove_all(Data,'\\d+'))) |>
  summarise(Answer = sum(N),.by = Data)
