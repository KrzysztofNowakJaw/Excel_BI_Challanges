#https://docs.google.com/spreadsheets/d/1wjhr7PZsYMi0Dy6is8lecyvadxKPYLAy/edit?gid=1449758384#gid=1449758384
df <- read_xlsx(File_name,range = "B2:E11")

df |>
  rowwise() |>
  mutate(Combine =  paste(sort(c_across(2:ncol(df))),collapse = "")) |>
  ungroup() |>
  filter(row_number() == 1,.by = Combine) |>
  select(-Combine)
