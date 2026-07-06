#https://www.linkedin.com/posts/excelbi_excel-challenge-problem-activity-7477571635047383040-2k57?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0

df <- read_xlsx(
  'Excel_Challenge_1010 - Record Alignment.xlsx',
  range = "A2:A24"
)


Missing_age <- df |>
  mutate(Index = cumsum(is.na(Data))) |>
  filter_out(is.na(Data)) |>
  group_by(Index) |>
  mutate(Contains_d = any(str_detect(Data, '\\d+'))) |>
  ungroup()

Full <- Missing_age |>
  filter(Contains_d) |>
  mutate(Internal = cumsum(str_detect(Data, '\\d+'))) |>
  summarise(Values = paste(Data, collapse = " "), .by = c(Index, Internal)) |>
  group_by(Index) |>
  mutate(Internal = row_number()) |>
  pivot_wider(id_cols = Index, names_from = Internal, values_from = Values) |>
  separate_wider_delim(
    `2`,
    names = c("Age", "City"),
    delim = " ",
    too_few = "align_start"
  ) |>
  rename(Names = `1`)


Missing <- Missing_age |>
  filter(!Contains_d) |>
  mutate(
    Group = case_when(
      cumsum(row_number() == n()) == 0 ~ 'Names',
      .default = 'City'
    )
  ) |>
  summarise(Data = paste(Data, collapse = " "), .by = c(Index, Group)) |>
  pivot_wider(id_cols = Index, names_from = Group, values_from = Data)


Full |>
  bind_rows(Missing)
