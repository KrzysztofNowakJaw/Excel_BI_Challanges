#Unfinished
#https://www.linkedin.com/posts/excelbi_excel-challenge-problem-activity-7429011727662522368-c_TJ?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0

library(tidyverse)
library(EBI)
library(hms)

df <- Excel_Bi_File(from = "A2", to = "D13")

Answer <- df |>
  separate_longer_delim(Time, delim = ',') |>
  separate_wider_delim(Time, delim = '-', names = c("From", "To")) |>
  mutate(
    From = paste(Date, From, sep = " ") |> as.POSIXct(),
    To = paste(Date, To, sep = " ") |> as.POSIXct(),
    Duration = difftime(as_hms(To), as_hms(From), units = "hours") |>
      as.numeric()
  ) |>
  mutate(
    Threshold_Low = paste(Date, '09:00', sep = " ") |> as.POSIXct(),
    Threshold_Up = paste(Date, '17:00', sep = " ") |> as.POSIXct(),
    Test_From = case_when(
      From < Threshold_Low ~ difftime(
        as_hms(Threshold_Low),
        as_hms(From),
        units = "hours"
      ) |>
        as.numeric(),
      .default = 0
    ),
    Test_To = case_when(
      To > Threshold_Up ~ difftime(
        as_hms(To),
        as_hms(Threshold_Up),
        units = "hours"
      ) |>
        as.numeric(),
      .default = 0
    ),
    Overhours = Test_From + Test_To,
    Is_week = weekdays(Date) %in% c('Saturday', 'Sunday')
  ) |>
  mutate(
    Regular_Hours = case_when(
      Is_week ~ 0,
      .default = Duration - Overhours
    ),
    Overtime_Hours = case_when(
      Is_week ~ 0,
      .default = Overhours
    ),
    Weekend_Hours = case_when(
      Is_week ~ Duration,
      .default = 0
    ),
    Billed_Amount = case_when(
      Is_week ~ Weekend_Hours * Rate * 1.5,
      .default = (Regular_Hours * Rate) + (Overtime_Hours * Rate * 1.2)
    )
  ) |>
  summarise(Sum = sum(Billed_Amount), .by = c(Resource))

Answer
