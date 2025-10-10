#Link to challange
#https://www.linkedin.com/posts/excelbi_excel-challenge-problem-activity-7193097156491100160-pmwm?utm_source=share&utm_medium=member_desktop

library(tidyverse)
library(readxl)


filename <- "Excel_Challenge_449 - Rotated Strings.xlsx"

df <- read_xlsx(filename, range = "A1:B10")

CheckRotation <- function(x, y) {
  Extended <- str_c(x, x)
  Check <- str_detect(Extended, y) & x != y
  return(Check)
}

Answer <- df |>
  filter(map2_lgl(String1, String2, CheckRotation))
