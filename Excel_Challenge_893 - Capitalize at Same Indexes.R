# Find the indexes where capital letters are.
# Remove the spaces.
# Make sentences lower case.
# Now, capitalize at those same indexes where the capital letters were.
# Insert spaces back where they were
# Ex. He rAn = Capital letters at indexes 1,5 => HeraN => He raN

#https://www.linkedin.com/posts/excelbi_excel-challenge-problem-activity-7417777627442274305-YM3n?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0

library(tidyverse)
library(glue)

df <- read_xlsx(File_name)


Capitalize_Selective <- function(x) {
  Split <- str_split_1(x, "")

  Capitals_Pos <- which(str_detect(Split, '[A-Z]'))

  Space_Pos <- which(str_detect(Split, '\\s'))

  Split_Cleaned <-
    str_to_lower(
      Split[str_to_lower(Split) %in% letters]
    )

  Split_Cleaned[Capitals_Pos] <- str_to_upper(Split_Cleaned[Capitals_Pos])

  Split_Cleaned <- Split_Cleaned[!is.na(Split_Cleaned)]

  Split[-Space_Pos] <- Split_Cleaned

  result <- paste(Split, collapse = "")

  return(result)
}

df |>
  mutate(My_Answer = map_chr(Sentences, Capitalize_Selective)) |>
  mutate(Test = `Answer Expected` == My_Answer) |>
  view()
