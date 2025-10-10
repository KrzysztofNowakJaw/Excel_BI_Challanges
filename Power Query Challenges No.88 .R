# Load necessary libraries for data manipulation and reading Excel files
library(tidyverse)
library(readxl)
library(gt)

# Define the filename of the Excel file containing the grid data
filename <- 'CH-088 Subtotal Calculation.xlsx'

df <- read_xlsx(filename, range = 'B2:E18')

Total <- df |>
  rowwise() |>
  mutate(
    `Total Regions` = sum(c_across(starts_with("Region"))),
    Season = as.factor(Season)
  ) |>
  mutate(Group = str_c('Product', Product, sep = ': '), .before = Product)


Total |>
  gt(groupname_col = 'Group', rowname_col = 'Product') |>
  summary_rows(
    fns = list(label = md("**Total**"), fn = "sum"),
    fmt = ~ fmt_number(., n_sigfig = 3, suffixing = TRUE, decimals = 0),
    side = "bottom",
    columns = contains('Region'),
  ) |>
  grand_summary_rows(
    columns = contains('Region'),
    fns = `Grand Total` ~ sum(.),
    fmt = list(
      ~ fmt_integer(., columns = contains('Region'))
    )
  ) |>
  opt_stylize(style = 5)
