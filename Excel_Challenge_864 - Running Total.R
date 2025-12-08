#https://onedrive.live.com/:x:/g/personal/E11B26EEAACB7947/EZ-EunwbLF9DugxPnNfuzTcBvhFGLyiW-68Ioiy_qHwoow?resid=E11B26EEAACB7947!s7cba849f2c1b435fba0c4f9cd7eecd37&ithint=file%2Cxlsx&e=FjTkg1&migratedtospo=true&redeem=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0VaLUV1bndiTEY5RHVneFBuTmZ1elRjQnZoRkdMeWlXLTY4SW9peV9xSHdvb3c_ZT1GalRrZzE
library(tidyverse)
library(readxl)

df <- read_xlsx(File_name, range = "A2:B70")

Answer <- df |>
  mutate(
    Month = month(Date, label = TRUE),
    Amount = case_when(wday(Date, week_start = 1) >= 6 ~ 0, .default = Amount)
  ) |>
  summarise(Amount = sum(Amount), .by = Month) |>
  mutate(`Running Total` = cumsum(Amount)) |>
  select(-Amount) |>
  view()

Answer
