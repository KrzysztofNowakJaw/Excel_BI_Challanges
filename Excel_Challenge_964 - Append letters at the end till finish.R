#https://onedrive.live.com/:x:/g/personal/E11B26EEAACB7947/IQDuVpV-CZP0RZs7EnuMi_pcAcURg2b2cqfqmafd1yTWHrU?resid=E11B26EEAACB7947!s7e9556ee930945f49b3b127b8c8bfa5c&ithint=file%2Cxlsx&e=IdR0Me&migratedtospo=true&redeem=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0lRRHVWcFYtQ1pQMFJaczdFbnVNaV9wY0FjVVJnMmIyY3FmcW1hZmQxeVRXSHJVP2U9SWRSME1l

library(readxl)
library(tidyverse)

df <- read_xlsx(File_name, range = "A1:B7")

Answer <- df |>
  mutate(Index = row_number(), .before = 1) |>
  separate_longer_delim(Strings, " ") |>
  rowwise() |>
  mutate(
    My_Answer = paste(
      accumulate(str_split_1(Strings, ""), paste0, .dir = "backward"),
      collapse = ""
    )
  ) |>
  ungroup() |>
  summarise(My_Answer = paste(My_Answer, collapse = " "), .by = Index)

Answer

Answer$My_Answer == df$`Answer Expected`
