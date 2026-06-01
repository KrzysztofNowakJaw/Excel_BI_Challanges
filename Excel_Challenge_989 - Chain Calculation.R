#https://onedrive.live.com/:x:/g/personal/E11B26EEAACB7947/IQCrKIpabxXVRZ37HOqf-wxzAV3rwy85k-kpjO63hLTWbvM?resid=E11B26EEAACB7947!s5a8a28ab156f45d59dfb1cea9ffb0c73&ithint=file%2Cxlsx&e=5reggp&migratedtospo=true&redeem=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0lRQ3JLSXBhYnhYVlJaMzdIT3FmLXd4ekFWM3J3eTg1ay1rcGpPNjNoTFRXYnZNP2U9NXJlZ2dw

library(readxl)
library(tidyverse)

df <- read_xlsx(File_name, range = "A2:C26")

Grouping <- df |>
  group_by(User) |>
  mutate(
    Diff = difftime(Timestamp, lag(Timestamp)),
    DiffLog = coalesce(
      as.numeric(difftime(Timestamp, lag(Timestamp))) <= 10,
      TRUE
    )
  ) |>
  mutate(DiffLog = cumsum(DiffLog == FALSE)) |>
  ungroup()

Answer <- Grouping |>
  summarise(
    `Chain Start` = min(Timestamp),
    `Chain Ends` = max(Timestamp),
    `Chain Total Value` = sum(Value),
    .by = c(User, DiffLog)
  ) |>
  slice_max(order_by = `Chain Total Value`, n = 1, by = User) |>
  inner_join(
    Grouping |> select(DiffLog, contains("TimeStamp")),
    join_by(DiffLog)
  ) |>
  select(-c(DiffLog, Timestamp)) |>
  unique()

Answer |> view()
