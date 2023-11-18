#Link to challange:
#https://www.linkedin.com/feed/update/urn:li:activity:7130766434120458240/

#List the top 3 marks and names and subjects against them. Sort them on the basis of Marks descending, Names and Subjects ascending.

# Load required libraries
library(tidyverse)
library(readxl) 

# Read data from Excel file
df <- read_xlsx("Highest Marks Names Subjects.xlsx", range = "A1:E10")

# Extract the matrix of marks from the data frame
Matrix <- as.matrix(df[, 2:ncol(df)])

# Find the top 3 unique marks
Top3 <- unique(sort(as.vector(Matrix), decreasing = TRUE))[1:3]

# Create a tidy data frame and filter for the top 3 marks, sorting as specified
Answer <- df |>
  pivot_longer(cols = 2:ncol(df), names_to = "Subjects", values_to = "Marks") |>
  filter(between(Marks, min(Top3), max(Top3))) |>
  arrange(desc(Marks), Names, Subjects)

# Display the result
Answer
