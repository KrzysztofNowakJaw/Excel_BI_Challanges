library(tidyverse)
library(readxl)

Answer <- df |>
  pivot_longer(cols = 2:ncol(df),names_to = 'Date',values_to = 'Price') |>
  mutate(
    Date = str_remove(Date,'Price in '),
    Price = coalesce(Price,0),
    Price = cumsum(Price),.by = Product)



Answer
