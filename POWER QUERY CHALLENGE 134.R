#Link to challange
#https://www.linkedin.com/feed/update/urn:li:activity:7134390317272711168/

# Load necessary libraries
library(tidyverse)
library(readxl)

# Read data from Excel files
T1 <- read_xlsx("PQ_Challenge_134.xlsx", range = "A1:D12")

# Read the second table and clean column names
T2 <- read_xlsx("PQ_Challenge_134.xlsx", range = "F1:G4") |>
  janitor::clean_names()

# Join the two tables, group by Store, and calculate ClosingStock based on conditions
Tables <- T1 |>
  left_join(T2, by = c("Store" = "store")) |>
  group_by(Store) |>
  mutate(
    ClosingStock = case_when(
      Date == min(Date) & row_number() == 1 ~ open_stock + (IN - OUT),
      TRUE ~ NA
    )
  )

# Define a function to iteratively fill NA values in ClosingStock
fill_na_iterative <- function(data) {
  while (any(is.na(data$ClosingStock))) {
    data <- data |>
      mutate(
        ClosingStock = case_when(
          is.na(ClosingStock) ~ lag(ClosingStock) + IN - OUT,
          TRUE ~ ClosingStock
        )
      )
  }
  return(data)
}

# Apply the fill_na_iterative function to the Tables data
result <- Tables |>
  fill_na_iterative()

# Print the final result
result
