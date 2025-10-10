#link to challenge
#https://www.linkedin.com/posts/omid-motamedisedeh-74aba166_excelchallenge-powerquerychllenge-excel-activity-7211473239376637954-5PJK?utm_source=share&utm_medium=member_desktop

library(tidyverse)
library(readxl)

filename <- "CH-073 Custom splitter 2.xlsx"

df <- read_xlsx(filename, range = "B2:B15")
Expected <- read_xlsx(
       filename,
       range = "D2:F24",
       col_types = c("text", "text", "text")
)

Date_pattern <- "^\\d{4}\\/\\d{1,2}\\/\\d{1,2}"

Answer <- df |>
       mutate(
              Date = str_extract(Info, Date_pattern),
              Info = str_remove(Info, Date_pattern),
              Values = str_extract_all(Info, "[[:alpha:]]+\\d+")
       ) |>
       unnest_longer(Values) |>
       mutate(
              Product = str_extract(Values, "^[[:alpha:]]+"),
              Quantity = str_extract(Values, "\\d+$")
       ) |>
       select(names(Expected))

Answer

all.equal(Expected, Answer)
