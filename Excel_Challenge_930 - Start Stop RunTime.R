library(tidyverse)
library(readxl)

df <- read_xlsx(File_name, range = "A2:C22")
Ex <- read_xlsx(File_name, range = "E2:H13")


df |>
  mutate(Cycle = cumsum(EventType == "Start"), .by = Machine) |>
  group_by(Machine, Cycle) |>
  mutate(Index = row_number()) |>
  complete(Index = seq(from = 1, to = 2)) |>
  mutate(
    EventType = case_when(is.na(EventType) ~ "Stop", .default = EventType),
    EventTime = case_when(
      is.na(EventTime) & hour(lag(EventTime)) < 18 ~ floor_date(
        lag(EventTime),
        unit = "day"
      ) +
        18 * 60 * 60,
      is.na(EventTime) & hour(lag(EventTime)) >= 18 ~ (ceiling_date(
        lag(EventTime),
        unit = "day"
      ) +
        1) +
        18 * 60 * 60,
      .default = EventTime
    )
  ) |>
  summarise(Values = list(EventTime), .groups = "drop_last") |>
  hoist(Values, StartTime = 1, StopTime = 2) |>
  mutate(
    RunMinutes = difftime(StartTime, StopTime, units = "mins") |> abs()
  ) |>
  select(-Cycle)
