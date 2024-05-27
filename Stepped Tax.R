#Link to challange
#https://www.linkedin.com/posts/omid-motamedisedeh-74aba166_excelchallenge-powerquerychllenge-excel-activity-7200601591740063744-Fmqt?utm_source=share&utm_medium=member_desktop
library(tidyverse)
library(readxl)

filename <- "CH-058 Stepped Tax.xlsx"
Tax <- read_xlsx(filename, range = "B2:D7") |> janitor::clean_names()
Main <- read_xlsx(filename, range = "F2:G7") |> janitor::clean_names()

Tax <- Tax |>
  mutate(
    to = as.numeric(to),
    to = ifelse(is.na(to), Inf, to)
  )

CalculateTax <- function(dataset) {
  Filtered <- dataset |>
    cross_join(Tax) |>
    pivot_longer(cols = c(from, to), names_to = "Category", values_to = "Border") |>
    mutate(
      AllBigger = cumall(income >= Border),
      AllBigger = ifelse(lag(AllBigger) == TRUE, TRUE, AllBigger)
    ) |>
    filter(AllBigger != FALSE)

  Answer <- Filtered |>
    mutate(
      Border = case_when(row_number() == nrow(Filtered) ~ income,
        .default = Border
      ),
      Tax = coalesce((lead(Border) - Border), 0) * tax_rate
    ) |>
    summarise(Tax = sum(Tax), .by = person_id)

  return(Answer)
}

IteratePerRow <- lapply(seq_len(nrow(Main)), function(i) CalculateTax(Main[i, ]))
Result <- bind_rows(IteratePerRow)

Result
