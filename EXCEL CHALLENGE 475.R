#link to challange
#https://www.linkedin.com/posts/excelbi_excel-challenge-problem-activity-7206140862215499776-5Y00?utm_source=share&utm_medium=member_desktop

library(tidyverse)

# Define the filename containing the data
filename <- "Excel_Challenge_475 - Split by Positions.xlsx"

# Read data from the specified Excel file and range
df <- read_xlsx(filename, range = "A2:B12")

df <- df |>
  mutate(Row = row_number())

ExtractTexts <- function(data) {
  StepOne <- data |>
    separate_longer_delim(Position, ",") |>
    mutate(
      Index = row_number(),
      Rows = max(Index),
      Position = as.numeric(Position),
      Previous = coalesce(lag(Position), 1),
      Extract = substr(Names, Previous, Position - 1),
      End = case_when(
        Index == Rows ~ substr(Names, Position, nchar(Names)),
        .default = NA
      )
    ) |>
    select(Row, Names, Extract, End)

  StepOne |>
    pivot_longer(cols = c(Extract, End)) |>
    filter(!is.na(value)) |>
    mutate(Index = row_number()) |>
    pivot_wider(
      id_cols = c(Row, Names),
      names_from = Index,
      values_from = value,
      names_prefix = "Text"
    )
}

groups <- df |>
  group_split(Names)

Results_df <- map_dfr(groups, ExtractTexts) |> arrange(Row) |> select(-Row)
