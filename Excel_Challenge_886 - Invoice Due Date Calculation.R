#https://www.linkedin.com/posts/excelbi_excel-challenge-problem-activity-7414516202913288192-BiVW?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0

df <- read_xlsx(File_name, range = "A1:D40")

Due_Dates <- df |>
  mutate(
    Add = case_when(
      Category == "A" ~ 30,
      Category == "B" ~ 45,
      Category == "C" ~ 60,
      TRUE ~ NA_real_
    ),
    Invoice_Date = as.Date(Invoice_Date) + Add,
    Month = month(Invoice_Date)
  ) |>
  select(-Add) |>
  mutate(Index = row_number(), .by = c(Category, Month))


Add_days_New <- function(tbl) {
  Threshold <- tbl |>
    summarise(Threshold = max(Index), .by = c(Category, Month)) |>
    summarise(Threshold = max(Threshold)) |>
    pull(Threshold)

  if (Threshold <= 2) {
    return(tbl)
  }

  tbl <- tbl |>
    mutate(Index = row_number(), .by = c(Category, Month)) |>
    mutate(
      Invoice_Date = case_when(
        Index > 2 ~ ceiling_date(Invoice_Date, unit = "month"),
        .default = Invoice_Date
      ),
      Month = month(Invoice_Date),
      Index = row_number(),
      .by = c(Category, Month)
    )

  Add_days_New(tbl)
}


Result <- Add_days_New(Due_Dates) |>
  mutate(
    Invoice_Date = case_when(
      weekdays(Invoice_Date) == "Saturday" ~ Invoice_Date + 2,
      weekdays(Invoice_Date) == "Sunday" ~ Invoice_Date + 1,
      TRUE ~ Invoice_Date
    )
  )
