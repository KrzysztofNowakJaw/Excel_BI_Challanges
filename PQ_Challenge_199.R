#Link to challange
#https://www.linkedin.com/posts/excelbi_challenge-powerquerychallenge-daxchallenge-activity-7217739351147872256-3VjL?utm_source=share&utm_medium=member_desktop

library(tidyverse)
library(readxl)

filename <- "PQ_Challenge_199.xlsx"

df <- read_xlsx(filename, range = "A1:A5")

StructureValue <- function(x) {
  datepattern <- "\\d+[[:punct:]]+\\d+[[:punct:]]+\\d+"

  tibble(
    Date = str_extract_all(x, pattern = datepattern),
    `Part No.` = str_extract_all(x, pattern = "\\d{3,}")
  ) |> unnest_longer(everything())
}

Combined <- map_dfr(df, StructureValue)

Answer <- Combined |>
  mutate(Date = str_replace_all(Date, "[[:punct:]]{2,}", "/\\")) |>
  mutate(Date = as.Date(Date, format = "%m/%d/%y")) |>
  arrange(`Part No.`, Date)

Answer
