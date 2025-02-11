# Link to challange
#https://www.linkedin.com/posts/excelbi_excel-challenge-problem-activity-7294928142001963008-OgYu?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0

library(tidyverse)
library(readxl)

my_files <- "Excel_Challenge_650 - Top 3 Across Columns.xlsx"

df <- read_excel(my_files, range = "A1:E15")

Top_Three <- function(x) {
  result <- paste(
    sort(unique(x[which(!is.na(x))]))[1:3],
    collapse = ","
  )
  return(result)
}

Answer <- map_dfr(df, Top_Three) |>
  pivot_longer(everything())

Answer
