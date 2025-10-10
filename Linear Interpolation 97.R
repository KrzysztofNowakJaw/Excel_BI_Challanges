#link to challange
#https://www.linkedin.com/posts/omid-motamedisedeh-74aba166_powerabrquery-excel-powerabrqueryabrtips-activity-7229230243260022785-HRQe?utm_source=share&utm_medium=member_desktop

library(tidyverse)
library(zoo)
library(readxl)

df <- read_xlsx("CH-097 Linear Interpolation.xlsx", range = c("B2:E5"))

Completed <- df |>
  complete(Year = seq(from = min(Year) - 1, to = max(Year) + 1, by = 1))

ToBeInterpolated <- Completed |>
  slice(2:(nrow(Completed) - 1))

Interpolate <- as.data.frame(lapply(
  ToBeInterpolated |>
    select(1:ncol(ToBeInterpolated)),
  zoo::na.approx
))

AllRows <- bind_rows(
  Completed |> head(1),
  Completed |> tail(1),
  Interpolate
) |>
  arrange(Year)

InterpolateMissingBorders <- function(x) {
  NaIndex <- which(is.na(x))
  Differences <- diff(x[!is.na(x)])
  fillVal <- Differences[c(1, length(Differences))]
  x[NaIndex] <- fillVal

  x <- case_when(
    row_number() == 1 ~ abs(x - lead(x)),
    row_number() == n() ~ x + lag(x),
    TRUE ~ x
  )

  return(x)
}

Answer <- AllRows |>
  mutate(across(2:ncol(AllRows), \(x) InterpolateMissingBorders(x)))

Answer
