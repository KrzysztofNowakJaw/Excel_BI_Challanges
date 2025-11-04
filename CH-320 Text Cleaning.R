#https://docs.google.com/spreadsheets/d/1oVkgahlVu0_PBK9TZ8q6sfq67TDTO1oe/edit?gid=1723613214#gid=1723613214
library(tidyverse)
library(readr)
library(janitor)

df <- read_xlsx(File_name, range = "B1:B7") |> clean_names()

Pattern <- '^[A-Z]+0+|^[A-Z]+'

str_view(df$question_id, Pattern)

Answer <- df |>
  mutate(Answer = str_remove(question_id, Pattern))
