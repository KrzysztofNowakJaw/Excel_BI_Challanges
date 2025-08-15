library(fs)
library(tidyverse)
library(readxl)

df <- read_xlsx(File_name, range = "A2:C12")

Categorized <- df |>
  pivot_longer(cols = everything()) |>
  drop_na() |>
  mutate(LastBird = cumall(value != "Quantity")) |>
  filter(value != "Quantity") |>
  arrange(desc(LastBird), name) |>
  mutate(Index = row_number(), .by = LastBird)

Birds <- Categorized |>
  filter(LastBird == TRUE) |>
  select(value)

Quantities <- Categorized |>
  filter(LastBird == FALSE) |>
  select(value)

Answer <- bind_cols(Birds, Quantities)

names(Answer) <- c("Bird", "Quantity")

Answer
