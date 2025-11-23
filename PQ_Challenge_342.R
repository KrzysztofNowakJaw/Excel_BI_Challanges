#under construction
#https://onedrive.live.com/:x:/g/personal/E11B26EEAACB7947/EXGf3VmEVkNOpAr1sEum5pQBf2DjGy1zUlQProbceYtgkA?resid=E11B26EEAACB7947!s59dd9f7156844e43a40af5b04ba6e694&ithint=file%2Cxlsx&e=ZDsgZY&migratedtospo=true&redeem=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0VYR2YzVm1FVmtOT3BBcjFzRXVtNXBRQmYyRGpHeTF6VWxRUHJvYmNlWXRna0E_ZT1aRHNnWlk

library(tidyverse)
library(readxl)

df <- read_xlsx('PQ_Challenge_342.xlsx', range = "A1:F19")

Indexed <- df |>
  mutate(Group = cumsum(Col1 %in% LETTERS), .before = 1)

Indexed |>
  split(Indexed$Group)

Indexed |>
  filter(Group == 1) |>
  mutate(across(everything(), \(x) as.character(x))) |>
  pivot_longer(2:7) |>
  drop_na() |>
  mutate(Cols = n() / 2)
