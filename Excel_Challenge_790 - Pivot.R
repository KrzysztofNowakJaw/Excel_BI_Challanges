#https://onedrive.live.com/personal/e11b26eeaacb7947/_layouts/15/Doc.aspx?sourcedoc=%7B6472f242-7825-4da7-8bfa-a3b98c8d6928%7D&action=default&redeem=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0VVTHljbVFsZUtkTmlfcWp1WXlOYVNnQldXUXc5ZVFkVUZKWENrSFd1RjBUa3c_ZT1NNjc0MUc&slrid=4394bfa1-d0c1-9000-dfcd-7261f8675b72&originalPath=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0VVTHljbVFsZUtkTmlfcWp1WXlOYVNnQldXUXc5ZVFkVUZKWENrSFd1RjBUa3c_cnRpbWU9d2x5ZS1iamszVWc&CID=885e9999-da23-4ba7-ba3b-82d74550b156&_SRM=0:G:56
library(tidyverse)
library(readxl)

df <- read_xlsx(
  '/Users/krzysztofnowak/Desktop/ExcelBi/Excel_BI_Challanges/Excel_Challenge_790 - Pivot.xlsx',
  range = "A2:A12"
)

Answer <- df |>
  separate_wider_delim(cols = Data, delim = ': ', names = c('A', 'B')) |>
  mutate(Name = case_when(A == 'Name' ~ B, .default = NA), .before = A) |>
  fill(everything(), .direction = "down") |>
  filter(A != 'Name') |>
  pivot_wider(id_cols = Name, names_from = A, values_from = B) |>
  separate_longer_delim(Department, delim = ' | ')
