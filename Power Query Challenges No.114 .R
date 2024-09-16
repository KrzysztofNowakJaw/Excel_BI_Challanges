# link to challange Power Query Challenges No.107
# https://www.linkedin.com/posts/omid-motamedisedeh-74aba166_powerabrquery-excel-powerabrqueryabrtips-activity-7241551427125313537-3y_8?utm_source=share&utm_medium=member_desktop
library(tidyverse)
library(readxl)

T1 <- read_xlsx("CH-114 Merge.xlsx", range = c("B3:C9"),,col_names = c('Date','Product_ID'))
T2 <- read_xlsx("CH-114 Merge.xlsx", range = c("B14:C18"),col_names = c('Product_ID','Price'))

T2 <- T2 |>
  mutate(Index = as.numeric(str_extract(Product_ID,"\\d+$")))

Solution <- T1 |>
  group_by(Date) |>
  separate_longer_delim(Product_ID,delim = ',') |>
  mutate(InitialProd = str_extract(Product_ID,"^x\\d+"),
         ProdIndex = as.numeric(str_extract(InitialProd,"\\d+$"))) |>
  left_join(T2,by = join_by(ProdIndex == Index)) |>
  mutate(Price = as.character(Price),
         Rows = n(),
         NAS = sum(is.na(Price)),
         Price = case_when(NAS == Rows ~ '-',.default = Price)) |>
  filter(!is.na(Price)) |>
  slice_head(n = 1) |>
  ungroup() |>
  select(Price)

Answer <- T1 |>
  bind_cols(Solution)

Answer
