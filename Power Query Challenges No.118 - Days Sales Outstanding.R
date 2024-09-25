#Link to challange
#https://www.linkedin.com/posts/omid-motamedisedeh-74aba166_powerabrquery-excel-powerabrqueryabrtips-activity-7244450548014350336-vHCD?utm_source=share&utm_medium=member_desktop

library(tidyverse)
library(readxl)

df <- read_xlsx(my_files, range = c("B2:D25"))

Balance <- read_xlsx(my_files, range = c("F2:G5")) |> 
  mutate(BOAD = as.Date('2024-08-31'))

Answer <- df |>
  left_join(Balance) |>
  group_by(Customer) |>
  arrange(Customer,desc(Date)) |>
  mutate(CS = cumsum(Sales),
         Test = cumall(Balance >= CS)) |>
  ungroup() |>
  mutate(Index = row_number(),.by = c(Customer,Test)) |>
  filter(Test == TRUE | Index == 1) |>
  group_by(Customer) |>
  mutate(DateDiff = as.numeric(abs(as.Date(Date)-BOAD)),
         Sales = abs(ifelse(Test == FALSE,lag(CS) - Balance,Sales))) |>
  select(Customer,Sales,DateDiff,Sales,Balance) |>
  reframe(Answer = sum(Sales * DateDiff)/Balance) |>
  unique() 

Answer
