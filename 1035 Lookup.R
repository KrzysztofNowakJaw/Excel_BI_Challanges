# Read the Excel file
Patterns <- read_xlsx("Excel_Challenge_1035 - Lookup.xlsx", range = "A1:B11")
Accounts <- read_xlsx("Excel_Challenge_1035 - Lookup.xlsx", range = "D1:E21")


Patterns$Regex <- Patterns$Pattern |>
  str_replace_all(fixed("*"), ".*") |>
  str_replace_all(fixed("?"), ".") |>
  (\(x) paste0("^", x, "$"))()


Result <- lapply(Accounts$Local_Acc, function(x) {
  data.frame(
    Account = x,
    Regex = Patterns$Regex |>
      keep(~ str_detect(x, pattern = .x))
  ) |>
    left_join(Patterns, by = "Regex") |>
    slice_max(order_by = nchar(Pattern), n = 1, by = Account) |>
    select(Account, Global_Account)
}) |>
  bind_rows()


Result |>
  view()


?glob
