#https://docs.google.com/spreadsheets/d/1ICH7jhyaZTOQQj3DbMI1M_3kkLWCBt5U/edit?gid=1076817523#gid=1076817523

library(readxl)
library(tidyverse)


df <- read_xlsx(File_name, range = "B3:D14")

Days_In_Scope <- df |>
  arrange(Date) |>
  mutate(Diff = as.numeric(ymd(Date) - lag(ymd(Date)))) |>
  filter(Diff > 1) |>
  pull(Date)

df |>
  filter(Date %in% Days_In_Scope)
