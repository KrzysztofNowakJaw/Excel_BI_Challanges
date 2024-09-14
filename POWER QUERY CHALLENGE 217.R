#Link to Challange
#https://www.linkedin.com/posts/excelbi_challenge-powerquerychallenge-daxchallenge-activity-7240571624696012800-4aqc?utm_source=share&utm_medium=member_desktop
library(tidyverse)

# Create the data frame
df <- data.frame(
  Customer = c("Karen", "Shirley", "Lawrence", "Christian"),
  Amt = c(1000, 2500, 900, 1200),
  Jan = c(0, 0, 1, 2),
  Feb = c(1, 0, 0, 3),
  Mar = c(0, 0, 3, 3),
  Apr = c(2, 0, 2, 0),
  May = c(0, 1, 1, 1),
  Jun = c(3, 2, 0, 1)
)

Answer <- df |>
  pivot_longer(cols = 3:ncol(df),names_to = "Months",values_to = "Multiply") |>
  mutate(Amt = Amt * Multiply) |>
  pivot_wider(id_cols  = Months,values_from = Amt,names_from = Customer) |>
  janitor::adorn_totals(c("row","col"))

Answer
