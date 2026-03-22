#https://www.linkedin.com/posts/omidmot_exclude-powerabrquery-excel-activity-7441227147668606976-528_?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0

library(tidyverse)
library(readxl)

df <- read_xlsx(File_name, range = "B3:E10")

Threshold <- as.Date('2024-08-14')

Answer <- df |>
  mutate(
    `Customer ID` = case_when(
      Date >= Threshold ~ str_replace(
        string = `Customer ID`,
        pattern = '^X',
        replacement = "C"
      ),
      .default = `Customer ID`
    )
  )

Answer$`Customer ID` == Ex$`Customer ID`
