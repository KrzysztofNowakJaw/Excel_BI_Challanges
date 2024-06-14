#link to challange
#https://www.linkedin.com/posts/omid-motamedisedeh-74aba166_excelchallenge-powerquerychllenge-excel-activity-7207124582229528576-FFF1?utm_source=share&utm_medium=member_desktop


# Load necessary libraries
library(tidyverse)  # For data manipulation
library(readxl)     # For reading Excel files

# Define the filename containing the data
filename <- "CH-067 Index Selections.xlsx"

# Read data from the specified Excel file and range
df <- read_xlsx(filename, range = "B2:H17")

# Define a function to check if an index has ranks <= 7 in at least two references
FindMatches <- function(x) {
  x <- unlist(x)  # Convert the input to a vector
  z <- length(x[x > 0 & x <= 7])  # Count how many ranks are <= 7
  result <- z > 1  # Check if there are at least two ranks <= 7
  return(result)
}

# Process the dataframe to find indexes meeting the criteria
Answer <- df |>
  rowwise() |>
  # Replace NA values with 0
  mutate(across(2:ncol(df), ~ coalesce(.x, 0)),
         # Create a list of values for each row
         List = list(c_across(2:ncol(df)))) |>
  # Filter rows where the function FindMatches returns TRUE
  filter(FindMatches(List) == TRUE) |>
  # Select only the first column (indexes)
  select(1)

# Display the result
Answer