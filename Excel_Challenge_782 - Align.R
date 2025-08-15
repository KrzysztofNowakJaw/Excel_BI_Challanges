#Link to challlange:
#https://onedrive.live.com/personal/e11b26eeaacb7947/_layouts/15/Doc.aspx?sourcedoc=%7B51803dad-b48b-4ed8-983f-21ca1018a0be%7D&action=default&redeem=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0VhMDlnRkdMdE5oT21EOGh5aEFZb0w0Qk9RRV9vcFpIVTZPcG1zMWVkMlVTSFE_ZT1pYVYxZUs&slrid=4113bca1-703d-9000-bb65-41c6f43a050d&originalPath=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0VhMDlnRkdMdE5oT21EOGh5aEFZb0w0Qk9RRV9vcFpIVTZPcG1zMWVkMlVTSFE_cnRpbWU9M2dseUFpdmMzVWc&CID=4a004a14-ad05-4598-94c3-de086972d2cd&_SRM=0:G:46

library(tidyverse)
library(readxl)

df <- read_xlsx(File_name, range = "A2:C12")

Categorized <- df |>
  pivot_longer(cols = everything()) |>
  drop_na() |>
  mutate(LastBird = cumall(value != "Quantity")) |>
  filter(value != "Quantity") |>
  arrange(desc(LastBird), name) |>
  select(value,LastBird)

Answer <- 
  Categorized |>
  filter(LastBird == TRUE) |>
  bind_cols(Categorized |>
              filter(LastBird == FALSE)) |>
  select(contains('value'))

names(Answer) <- c("Bird", "Quantity")





