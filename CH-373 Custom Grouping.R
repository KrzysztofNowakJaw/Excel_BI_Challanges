#https://www.linkedin.com/posts/omidmot_exclude-powerabrquery-excel-activity-7432529854496989184-u9Kk?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0

df <- read_xlsx(File_name, range = "B3:E11") |>
  janitor::clean_names() |>
  select(total_sales) |>
  mutate(Index = row_number(), .before = 1)

target_n <- nrow(df)

result <- df[0, ]

Recent_Row <- 0

while (Recent_Row < target_n) {
  Run <- df |>
    filter(Index > Recent_Row) |>
    mutate(
      CS = cumsum(total_sales),
      Check = cumany(between(CS, 600, 1200))
    ) |>
    filter(Check == TRUE) |>
    select(-Check) |>
    head(1)

  result <- bind_rows(result, Run)
  Recent_Row <- max(Run$Index)
}

result |>
  mutate(Group = paste("Group", row_number()), .before = 1) |>
  select(Group, CS) |>
  view()
