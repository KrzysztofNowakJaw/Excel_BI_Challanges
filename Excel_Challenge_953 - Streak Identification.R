#https://onedrive.live.com/:x:/g/personal/E11B26EEAACB7947/IQC216dCIdIbRYEcJN_2gvyOAevXSSfdTt9fJj1ud9X711I?resid=E11B26EEAACB7947!s42a7d7b6d221451b811c24dff682fc8e&ithint=file%2Cxlsx&e=Wzfbva&migratedtospo=true&redeem=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0lRQzIxNmRDSWRJYlJZRWNKTl8yZ3Z5T0FldlhTU2ZkVHQ5ZkpqMXVkOVg3MTFJP2U9V3pmYnZh

library(tidyverse)
library(readxl)

df <- read_xlsx(File_name, range = "A2:C24")

Answer <- df |>
  group_by(MachineID) |>
  mutate(
    Group = consecutive_id(Value >= 80 | (Value < 80 & lead(Value >= 80)))
  ) |>
  ungroup() |>
  filter(cumany(Value >= 80), .by = c(MachineID, Group)) |>
  ungroup() |>
  summarise(
    StartID = min(TimeID),
    EndID = max(TimeID),
    .by = c(MachineID, Group)
  ) |>
  select(-Group)

Answer

?consecutive_id
?cumany
