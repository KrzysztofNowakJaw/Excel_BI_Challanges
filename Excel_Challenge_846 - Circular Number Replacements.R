#https://onedrive.live.com/personal/e11b26eeaacb7947/_layouts/15/Doc.aspx?sourcedoc=%7B4f5d7c24-a846-419f-a9e8-b212062e16e6%7D&action=default&redeem=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0VTUjhYVTlHcUo5QnFlaXlFZ1l1RnVZQl9SSzU1aEpiYldpcnZCa04tZ195Z2c_ZT1MYmtoOVA&slrid=d0b6d8a1-d0f4-a000-883b-136f27f73cf6&originalPath=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0VTUjhYVTlHcUo5QnFlaXlFZ1l1RnVZQl9SSzU1aEpiYldpcnZCa04tZ195Z2c_cnRpbWU9QkRoYVZCWWkza2c&CID=f084ce88-2786-459a-8c07-a3a9a1bec64c&_SRM=0:G:52
df <- read_xlsx(File_name, range = "A1:A10")
Expected <- read_xlsx(File_name, range = "B1:B10")

ReplaceNumbers <- function(x) {
  Base <- data.frame(A = x) |>
    mutate(Values = str_extract_all(A, '[a-zA-Z]+|\\d+')) |>
    unnest(Values) |>
    mutate(DigitsIndex = row_number(), .by = A)

  Numbers <- Base |>
    filter(str_detect(Values, '\\d+'))

  NumbersReplaced <- Numbers |>
    left_join(Numbers, join_by(closest(DigitsIndex < DigitsIndex))) |>
    mutate(
      Values.y = case_when(
        is.na(Values.y) ~ first(Values.x),
        .default = Values.y
      )
    )

  Base |>
    left_join(NumbersReplaced, join_by(DigitsIndex == DigitsIndex.x)) |>
    mutate(Answer = case_when(is.na(Values.y) ~ Values, .default = Values.y)) |>
    summarise(Answer = paste(Answer, collapse = ""), .by = A) |>
    pull(Answer)
}

Solutions <- lapply(df$Data, ReplaceNumbers)
Answer <- do.call(rbind, Solutions) |> as.data.frame()
Answer |> view()
all.equal(Answer$V1, Expected$`Answer Expected`)
