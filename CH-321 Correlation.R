#https://www.linkedin.com/posts/omidmot_exclude-powerabrquery-excel-activity-7391580003722825728-3pGV?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0

library(corrr)
library(tidyverse)
library(readxl)
library(data.table)
library(gt)

T1 <- read_xlsx(File_name, range = "B2:F8")
T2 <- read_xlsx(File_name, range = "B13:E19") |> arrange(Year)

T1_Pivot <-
  T1 |>
  pivot_longer(cols = 2:ncol(T1), values_to = "factor") |>
  reframe(Vector = list(factor), .by = name)

T2_Pivot <-
  T2 |>
  pivot_longer(cols = 2:ncol(T2), values_to = "factor") |>
  reframe(Vector = list(factor), .by = name)

Combinations <- T2_Pivot |>
  cross_join(T1_Pivot)

Correlations <- map2(
  .x = Combinations$Vector.x,
  Combinations$Vector.y,
  .f = correlate
) |>
  rbindlist()

Combinations$Correlations <- Correlations$x

Combinations |>
  select(contains(c("name", "Correlations"))) |>
  pivot_wider(
    id_cols = name.x,
    names_from = name.y,
    values_from = Correlations
  ) |>
  gt()
