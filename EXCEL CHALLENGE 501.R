# Load necessary libraries for data manipulation and reading Excel files
library(tidyverse)
library(readxl)

# Define the filename of the Excel file containing the grid data
filename <- 'Excel_Challenge_501 - Find Consecutives in Grid.xlsx'

# Read the data from the specified range in the Excel file into a dataframe
df <- read_xlsx(filename, range = 'B1:M10', col_names = LETTERS[2:13])

# Function to find unique consecutive numbers in a given vector
FindCons <- function(x) {
  # Find the indices where the difference between consecutive elements is 0
  # and return the unique numbers at those indices
  unique(x[which(diff(x) == 0)])
}

# Apply the FindCons function to each column of the dataframe
ResultCols <- apply(df, 2, FindCons)

# Apply the FindCons function to each row of the dataframe
ResultRows <- apply(df, 1, FindCons)

# Combine the results from columns into a single vector
Cols <- do.call(rbind, ResultCols)

# Combine the results from rows into a single vector
Rows <- do.call(rbind, ResultRows)

# Combine and sort the unique consecutive numbers from both columns and rows
Answer <- unique(sort(c(Cols, Rows)))

# Print the final sorted list of unique consecutive numbers
print(Answer)
