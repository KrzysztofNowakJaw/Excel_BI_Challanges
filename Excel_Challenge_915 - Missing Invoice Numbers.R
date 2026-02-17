#unfinished

#https://onedrive.live.com/:x:/g/personal/E11B26EEAACB7947/IQCN-TC-iB6GSadnqu4lWXsiAdM6bOuk_OlDkbw5VmbCy24?resid=E11B26EEAACB7947!sbe30f98d1e884986a767aaee25597b22&ithint=file%2Cxlsx&e=l0PyxH&migratedtospo=true&redeem=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0lRQ04tVEMtaUI2R1NhZG5xdTRsV1hzaUFkTTZiT3VrX09sRGtidzVWbWJDeTI0P2U9bDBQeXhI

library(tidyverse)
library(hms)
library(EBI)


df <- Excel_Bi_File(from = "A1", to = "B24")

Features <- df |>
  mutate(
    Series = str_extract(Invoice_ID, '^[A-Z]+'),
    Number = str_extract(Invoice_ID, '\\d+$') |> as.numeric(),
    .before = 1
  )
Answer <- Features |>
  group_by(Series) |>
  complete(Number = seq(from = min(Number), to = max(Number), by = 1)) |>
  filter(is.na(Invoice_ID)) |>
  mutate(Invoice_ID = paste(Series, Number, sep = '-')) |>
  arrange(desc(Series), Invoice_ID) |>
  ungroup() |>
  select(Invoice_ID) |>
  view()
