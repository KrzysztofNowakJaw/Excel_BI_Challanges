#https://www.linkedin.com/posts/excelbi_excel-challenge-problem-activity-7409080316180451329-ddqi?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0

df <- read_xlsx(File_name) |> mutate(Index = row_number(), .before = 1)

SumMatches <- function(Element) {
  tibble(Letters = str_split_1(Element, "")) |>
    summarise(
      Test = as.character(sum(
        Letters < lead(Letters, default = as.character(0))
      ))
    ) |>
    pull(Test)
}

Result <- df |>
  separate_longer_delim(Data, delim = " ") |>
  mutate(W = map_chr(Data, SumMatches)) |>
  summarise(
    My_Answer = as.numeric(
      paste(W, collapse = "")
    ),
    .by = c(Index)
  ) |>
  mutate(My_Answer = na_if(My_Answer, 0))

df |>
  left_join(Result) |>
  view()
