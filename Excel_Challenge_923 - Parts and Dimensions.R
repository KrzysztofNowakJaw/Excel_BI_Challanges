#https://www.linkedin.com/posts/excelbi_excel-challenge-problem-activity-7432997972411523072-OyG5?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0

df <- read_xlsx(File_name, range = "A2:A20")

Ex <- read_xlsx(File_name, range = "C2:D20")

df |>
  mutate(
    Part = str_extract(Data, 'P[A-Z\\d+]{2,}'),
    Dimensions = str_extract_all(Data, '\\d*\\s?[x\\*]\\s?\\d*\\.?\\d')
  ) |>
  unnest(Dimensions) |>
  mutate(
    Dimensions = str_replace_all(Dimensions, '[\\s\\*\\+x]', replacement = ' ')
  ) |>
  separate_longer_delim(Dimensions, delim = ' ') |>
  filter(str_detect(Dimensions, '\\d+')) |>
  mutate(Dimensions = as.numeric(Dimensions)) |>
  summarise(
    `Sum of Dimensions` = reduce(Dimensions, `+`),
    .by = c(Data, Part)
  ) |>
  view()
