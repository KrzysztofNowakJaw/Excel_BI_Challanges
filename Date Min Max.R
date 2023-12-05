#Link to challange
#https://www.linkedin.com/feed/update/urn:li:activity:7137651807329173504/

#libraries

library(tidyverse)
library(readxl)

#load data

df <- read_xlsx("Date Min Max.xlsx",range = "A1:A20")


Answer <- df |>
  #Date operations. Extracting components and conditional columns
  mutate(
    Date = as.Date(Date),
    Year = year(Date),
    Half = ifelse(month(Date) <= 6,"1H","2H")) |>
  #Get smaller and biggest date in groups
  summarise(MinDate = min(Date),
            MaxDate = max(Date)
            ,.by = c("Year","Half")) |>
  #apply new dae format for every date column
  mutate(across(where(is.Date),\(x) format(x,"%d-%b-%Y"))) |>
  #Sort values
  arrange(Year,Half)

Answer
