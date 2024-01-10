#Link to challange:
#https://www.linkedin.com/feed/update/urn:li:activity:7149610605153337344/

# For a group -  List the last row where value < Threshold
# and also list the first row where value > Threshold
# If more than one row meets the criterion, then capture all those rows.

# Load required libraries
library(tidyverse)
library(readxl) 

# Read data from Excel file and clean column names for 'Names'
Task <- read_xlsx("PQ_Challenge_146.xlsx", range = "A1:D14")
Expected <- read_xlsx("PQ_Challenge_146.xlsx", range = "F1:I7")


FirstBigger <- Task |>
  group_by(Group) |>
  mutate(FirstBiggerIndex = match(TRUE,cumany(Value > Threshold)),
         FirstBiggerValue = ifelse(Seq == FirstBiggerIndex,Value,NA)) |>
  fill(FirstBiggerValue,.direction = "updown") |>
  rowwise() |>
  filter(Seq == FirstBiggerIndex || Value == FirstBiggerValue) |>
  select(names(Expected))

LastSmaller <- Task |>
  group_by(Group) |>
  mutate(LastSmallerIndex = max(which(cumall(Value < Threshold) == TRUE)),
         LastSmallerValue = ifelse(Seq == LastSmallerIndex,Value,NA)) |>
  fill(LastSmallerValue,.direction = "updown") |>
  rowwise() |>
  filter(Seq == LastSmallerIndex || Value == LastSmallerValue) |>
  select(names(Expected))

Answer <- bind_rows(LastSmaller,FirstBigger) |>
  arrange(Group)

Answer