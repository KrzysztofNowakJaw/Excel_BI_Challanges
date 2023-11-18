#List the Top 3 Matches where difference between 
#goals are the maximum and list them in descending order of goal difference.

#Link to challange:
#https://onedrive.live.com/view.aspx?resid=E11B26EEAACB7947%218678&authkey=!ACx7s1HH-rBJk0E

# Load required libraries
library(tidyverse)
library(readxl) 

# Read data from Excel file and clean column names
df <- read_xlsx("Teams Goal Diff is Same.xlsx", range = "A1:D11") |> janitor::clean_names()

# Separate the 'result' column into 'Team1Goals' and 'Team2Goals', calculate the goal difference, and filter the top 4 differences
Answer <- df |>
  separate_wider_regex(result, c(Team1Goals = "^\\d+", "-", Team2Goals = "\\d+$")) |>
  mutate(Diff = abs(as.integer(Team1Goals) - as.integer(Team2Goals))) |>
  filter(dense_rank(Diff) > 4) |>
  arrange(desc(Diff))

# Display the result
Answer

