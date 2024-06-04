library(dplyr)
library(tidyr)
library(lubridate)
library(scales)

filename <- "CH-062 Missing Values.xlsx"

df <- read_xlsx(filename, range = "B2:D21", col_types = c("date", "text", "numeric"))
Expected <- read_xlsx(filename, range = "H2:J38", col_types = c("date", "text", "numeric")) |> mutate(`Actual Progress` = percent(`Actual Progress`))

Base <- df |>
  mutate(
    DateFloor = floor_date(Date, unit = "month")
  ) |>
  group_by(Project) |>
  complete(DateFloor = seq.Date(from = min(as.Date(DateFloor)), to = max(as.Date(DateFloor)), by = "1 month")) |>
  mutate(Index = row_number()) |>
  arrange(Project, DateFloor) |>
  select(-c(Date))

interpolate_project <- function(df, project) {
  Base <- df %>%
    filter(Project == project)

  Populated <- Base |>
    filter(!is.na(`Actual Progress`)) |>
    mutate(PopIndex = Index) |>
    select(PopIndex)


  Empty <- Base |>
    filter(is.na(`Actual Progress`)) |>
    mutate(EmptyIndex = Index) |>
    select(EmptyIndex)

  Intervals <- Empty |>
    left_join(Populated, join_by(closest(EmptyIndex > PopIndex))) |>
    left_join(Populated, join_by(closest(EmptyIndex < PopIndex))) |>
    select(Project, EmptyIndex, PopIndex.x, PopIndex.y)


  result <- Intervals |>
    left_join(Base[, 3:4], by = c("PopIndex.x" = "Index")) |>
    left_join(Base[, 3:4], by = c("PopIndex.y" = "Index")) |>
    mutate(
      Diff = `Actual Progress.y` - `Actual Progress.x`,
      DiffMonths = PopIndex.y - PopIndex.x,
      TotalDiff = Diff / DiffMonths,
      Segment = paste(PopIndex.x, PopIndex.y, sep = "-"),
      AC = `Actual Progress.x`
    ) |>
    select(Project, Segment, EmptyIndex, AC, TotalDiff) |>
    group_by(Project, Segment) |>
    mutate(
      AC = if_else(row_number() == 1, AC, 0),
      Cum = percent(cumsum(AC + TotalDiff)),
      Index = EmptyIndex
    ) |>
    select(Project, Index, Cum)
  return(result)
}

unique_projects <- unique(df$Project)

MissingValues <- map_dfr(unique_projects, ~ interpolate_project(Base, .x))

Answer <- Base |>
  left_join(MissingValues, by = c("Project", "Index"), keep = FALSE) |>
  mutate(
    Date = floor_date(as.Date(DateFloor), "month") + months(1) - days(1),
    `Actual Progress` = ifelse(is.na(`Actual Progress`), Cum, percent(`Actual Progress`, accuracy = 1))
  ) |>
  select(Project, Date, `Actual Progress`)

Answer
