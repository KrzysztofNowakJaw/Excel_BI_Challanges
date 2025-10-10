#Link to challange:
#https://www.linkedin.com/feed/update/urn:li:activity:7131230938914582529/

# Load required libraries
library(tidyverse)
library(readxl)

# Read data from Excel file
df <- read_xlsx("Remove Minimum.xlsx", range = "A1:A7")

# Define a function to remove the last occurrence of the minimum value in a comma-separated string
RemoveLastMin <- function(x) {
  # Convert the comma-separated string to a numeric vector
  NumberConversion <- as.numeric(unlist(str_split(x, ",")))

  # Find the index of the minimum value
  min_index <- which.min(NumberConversion)

  # Remove the last occurrence of the minimum value
  RemoveIndex <- NumberConversion[-min_index]

  # Convert the modified vector back to a string
  result <- paste(unlist(str_split(RemoveIndex, " ")), collapse = ",")

  # Print the result
  print(result)
}

# Apply the RemoveLastMin function to each element in the 'String' column and store the results in the 'Answer' column
df$Answer <- sapply(df$String, RemoveLastMin)
