library(readxl)
library(tidyverse)

df <- read_xlsx(File_name, range = "A1:A31")

Separated <- df |>
  separate_wider_delim(Event, delim = ";", names = c("Event", "Temp")) |>
  mutate(Temp = as.numeric(Temp))


Answer <- Separated |>
  group_by(Event) |>
  mutate(Test = Temp > 8 | Temp < 2) |>
  mutate(T_Group = consecutive_id(Test == TRUE)) |>
  group_by(Event, T_Group) |>
  mutate(Index = row_number(), Answer = case_when(Index == 3 ~ "QUARANTINE")) |>
  ungroup() |>
  group_by(Event) |>
  mutate(
    Answer = case_when(
      cumany(Answer == "QUARANTINE") == TRUE ~ "QUARANTINE",
      .default = NA
    )
  ) |>
  select(Event, , Temp, Answer)

Answer |>
  view()
