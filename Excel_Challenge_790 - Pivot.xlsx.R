# R 4.5.0 started.
#
# R version 4.5.0 (2025-04-11) -- "How About a Twenty-Six"
# Copyright (C) 2025 The R Foundation for Statistical Computing
# Platform: aarch64-apple-darwin20
#
# R is free software and comes with ABSOLUTELY NO WARRANTY.
# You are welcome to redistribute it under certain conditions.
# Type 'license()' or 'licence()' for distribution details.
#
#   Natural language support but running in an English locale
#
# R is a collaborative project with many contributors.
# Type 'contributors()' for more information and
# 'citation()' on how to cite R or R packages in publications.
#
# Type 'demo()' for some demos, 'help()' for on-line help, or
# 'help.start()' for an HTML browser interface to help.
# Type 'q()' to quit R.
#
separate_longer_delim(Department, delim = ' | ')
# Error in `separate_longer_delim()`:
# ! could not find function "separate_longer_delim"
library(tidyverse)
# ── Attaching core tidyverse packages ─────────────────────────────────────────────────────────────────────────────────────────────────── tidyverse 2.0.0 ──
# ✔ dplyr     1.1.4     ✔ readr     2.1.5
# ✔ forcats   1.0.0     ✔ stringr   1.5.1
# ✔ ggplot2   3.5.2     ✔ tibble    3.2.1
# ✔ lubridate 1.9.4     ✔ tidyr     1.3.1
# ✔ purrr     1.0.4
# ── Conflicts ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
# ✖ dplyr::filter() masks stats::filter()
# ✖ dplyr::lag()    masks stats::lag()
# ℹ Use the conflicted package ([object Object])  to force all conflicts to become errors
library(readxl)
df <- read_xlsx(
  '/Users/krzysztofnowak/Desktop/ExcelBi/Excel_BI_Challanges/Excel_Challenge_790 - Pivot.xlsx',
  range = "A2:A12"
)
Answer <- df |>
  separate_wider_delim(cols = Data, delim = ': ', names = c('A', 'B')) |>
  mutate(Name = case_when(A == 'Name' ~ B, .default = NA), .before = A) |>
  fill(everything(), .direction = "down") |>
  filter(A != 'Name') |>
  pivot_wider(id_cols = Name, names_from = A, values_from = B) |>
  separate_longer_delim(Department, delim = ' | ')


Answer
# # A tibble: 4 × 4
#   Name   Salary Age   Department
#   <chr>  <chr>  <chr> <chr>
# 1 Robert 30000  45    NA
# 2 Ana    75000  52    Marketing
# 3 Ana    75000  52    Sales
# 4 Thomas 48000  NA    HR
# R 4.5.0 exited (preparing for restart)
# R 4.5.0 restarted.
Answer
# Error:
# ! object 'Answer' not found
# R 4.5.0 exited (preparing for restart)
# R 4.5.0 restarted.
library(tidyverse)
# ── Attaching core tidyverse packages ─────────────────────────────────────────────────────────────────────────────────────────────────── tidyverse 2.0.0 ──
# ✔ dplyr     1.1.4     ✔ readr     2.1.5
# ✔ forcats   1.0.0     ✔ stringr   1.5.1
# ✔ ggplot2   3.5.2     ✔ tibble    3.2.1
# ✔ lubridate 1.9.4     ✔ tidyr     1.3.1
# ✔ purrr     1.0.4
# ── Conflicts ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
# ✖ dplyr::filter() masks stats::filter()
# ✖ dplyr::lag()    masks stats::lag()
# ℹ Use the conflicted package ([object Object])  to force all conflicts to become errors
library(readxl)
df <- read_xlsx(
  '/Users/krzysztofnowak/Desktop/ExcelBi/Excel_BI_Challanges/Excel_Challenge_790 - Pivot.xlsx',
  range = "A2:A12"
)
Answer <- df |>
  separate_wider_delim(cols = Data, delim = ': ', names = c('A', 'B')) |>
  mutate(Name = case_when(A == 'Name' ~ B, .default = NA), .before = A) |>
  fill(everything(), .direction = "down") |>
  filter(A != 'Name') |>
  pivot_wider(id_cols = Name, names_from = A, values_from = B) |>
  separate_longer_delim(Department, delim = ' | ')
Answer
# # A tibble: 4 × 4
#   Name   Salary Age   Department
#   <chr>  <chr>  <chr> <chr>
# 1 Robert 30000  45    NA
# 2 Ana    75000  52    Marketing
# 3 Ana    75000  52    Sales
# 4 Thomas 48000  NA    HR
