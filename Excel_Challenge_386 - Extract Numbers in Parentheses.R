#Link to challange https://www.linkedin.com/feed/update/urn:li:activity:7160844652193984512/

library(tidyverse)
library(readxl)

filename <- "Excel_Challenge_386 - Extract Numbers in Parentheses.xlsx"

df <- read_xlsx(path = filename, range = "A1:A10")

pattern <- "(?<=\\()\\d+(?=\\))"

Answer <- df |>
  mutate(
    Answer = map_chr(
      String,
      ~ paste(unlist(str_extract_all(., pattern)[[1]]), collapse = ",")
    )
  )

Answer
