#https://docs.google.com/spreadsheets/d/16rHkZvuhUjsOVV3izrpOQIOggh8ZsW2d/edit?gid=151866309#gid=151866309
library(tidyverse)

df <- read_xlsx(File_name, range = "B2:B9")

Pattern <- '(?:Under\\s|Upper\\s|\\s)Ground|Ground'

Answer <- df |>
  rowwise() |>
  mutate(
    Answer = paste(
      unlist(str_extract_all(
        Level,
        pattern = Pattern
      )),
      collapse = ","
    ),
    .keep = "unused"
  )

Answer
