#challange: https://docs.google.com/spreadsheets/d/1QBOkpqvc_JBox78nx-AGu_azN_2Za_fv/edit?gid=760265087#gid=760265087
df <- read_xlsx(File_name, range = "B2:E6")
Expected <- read_xlsx(File_name, range = "I2:K13")

CleanDate <- "(?<=.{11})\\d{1,}$"
names(df) <- sapply(names(df), function(x) {
  str_remove(x, CleanDate)
})

Answer <- df |>
  mutate(Index = row_number(), .before = names(df)[1]) |>
  pivot_longer(cols = 2:5) |>
  separate_wider_delim(cols = value, delim = '-', names = c("A", "B")) |>
  mutate(name = as.Date(name, tryFormats = c("%d/%b/%Y"))) |>
  filter(!is.na(B)) |>
  select(2:4)

names(Answer) <- names(Expected)

Answer
