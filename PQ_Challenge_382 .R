library(tidyverse)
library(readxl)
library(janitor)


df <- read_xlsx('PQ_Challenge_382.xlsx', range = "A1:D22") |>
  janitor::clean_names()


components <- df |>
  select(-unit_cost) |>
  inner_join(df, join_by(component == parent_assembly)) |>
  summarise(unit_cost_x = (sum(unit_cost * qty.y)), .by = component)

Parents_Components <- df |>
  left_join(components) |>
  mutate(unit_cost = if_else(is.na(unit_cost), unit_cost_x, unit_cost)) |>
  summarise(unit_cost = sum(unit_cost * qty), .by = parent_assembly) |>
  filter_out(is.na(unit_cost))

tier1 <- Parents_Components |>
  filter_out(parent_assembly %in% df$component)

tier2 <- df |>
  anti_join(Parents_Components, join_by(parent_assembly)) |>
  left_join(components, join_by(component)) |>
  left_join(Parents_Components, join_by(component == parent_assembly)) |>
  mutate(
    unit_cost = max(c_across(where(is.numeric)), na.rm = TRUE),
    .keep = "unused",
    .by = component
  ) |>
  summarise(unit_cost = sum(unit_cost), .by = parent_assembly)

Answer <- bind_rows(tier1, tier2)
