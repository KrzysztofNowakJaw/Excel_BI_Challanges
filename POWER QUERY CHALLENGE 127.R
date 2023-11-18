#Find out the Zodiac signs for table T1 from Table T2.
#Note - Dates are in MDY format.

#Link to challange:
#https://onedrive.live.com/view.aspx?resid=E11B26EEAACB7947%218672&authkey=!AGa5EMUgyEtNUxc

# Load required libraries
library(tidyverse)
library(readxl) 

# Read data from Excel file and clean column names for 'Names'
names <- read_xlsx("PQ_Challenge_127.xlsx", range = "A1:B11") |> janitor::clean_names()

# Read data from Excel file and clean column names for 'Zodiak'
Zodiak <- read_xlsx("PQ_Challenge_127.xlsx", range = "D1:D13") |> janitor::clean_names()

# Process 'Names' data: create 'MonthDay' column and convert it to Date format
Names <- names |>
  mutate(MonthDay = paste("1990", format(date_of_birth, "%B %d"), sep = "-"),
         MonthDay = as.Date(MonthDay, "%Y-%B %d"))

# Process 'Zodiak' data: separate the 'zodiac_signs' column into various components and convert them to Date format
ZodiakCleaned <- Zodiak |>
  separate_wider_regex(zodiac_signs, c(Sign = "^\\w+",
                                       "\\s\\(",
                                       Start = "[[:alpha:]]+\\s\\d{2}",
                                       " – ", 
                                       End = "[[:alpha:]]+\\s\\d{2}"),
                       too_few = "align_start") |>
  mutate(across(!contains("Sign"), \(x) paste("1990", x, sep = "-")),
         across(!contains("Sign"), \(x) as.Date(x, "%Y-%B %d")))

# Merge 'ZodiakCleaned' and 'Names' data, filter by date range, and select relevant columns
Answer <- merge(ZodiakCleaned, Names) |>
  filter(MonthDay >= Start & MonthDay <= End) |>
  select(name, date_of_birth, Sign)

# Display the result
Answer

