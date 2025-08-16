#Link to challange:
#https://onedrive.live.com/:x:/g/personal/E11B26EEAACB7947/EaI7lZ1Tgn5DvZLcNr_jlXoBQJoeKYFoAtTFi3DuUVp14w?resid=E11B26EEAACB7947!s9d953ba28253437ebd92dc36bfe3957a&ithint=file%2Cxlsx&e=22spis&migratedtospo=true&redeem=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0VhSTdsWjFUZ241RHZaTGNOcl9qbFhvQlFKb2VLWUZvQXRURmkzRHVVVnAxNHc_ZT0yMnNwaXM

library(tidyverse)
library(readxl)

df <- read_xlsx(File_name,range = "A1:B18")

Answer <- df |>
  mutate(Customer = case_when(!str_detect(Data2,'\\d+') ~ Data2,default = NULL),
         Data1 = str_remove(Data1,'\\d+$')) |>
  fill(Customer,.direction = "down") |>
  filter(Data1 != 'Customer') |>
  summarize(Values = sum(as.numeric(Data2)),.by = c(Customer,Data1)) |>
  pivot_wider(id_cols = Customer,names_from = Data1,values_from = Values) |>
  mutate(across(where(is.numeric),\(x) ifelse(is.na(x),0,x)),
         Total = Quantity * (Price - Discount - Tax)) |>
  select(Customer,Total) |>
  janitor::adorn_totals()

Answer





