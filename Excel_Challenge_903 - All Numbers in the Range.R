#https://www.linkedin.com/posts/excelbi_excel-challenge-problem-activity-7422851071758303233-HZsL?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0

Is_Between <- function(x) {
  Sequences <- str_extract_all(x, '\\d+-\\d+')[[1]]

  Numbers <- str_extract_all(x, '\\d+')[[1]] |> as.numeric()

  Top <- max(Numbers)

  Bottom = min(Numbers)

  Unfold <- lapply(Sequences, function(x) {
    seq(from = str_extract(x, '^\\d+'), to = str_extract(x, '\\d+$'))
  }) |>
    unlist()

  Scope <- unique(c(Unfold, Numbers)) |> sort()
  All_Values <- Bottom:Top

  if (length(Scope) == length(All_Values)) {
    all(Scope == All_Values)
  } else {
    FALSE
  }
}

Answer <- keep(df$Data, Is_Between)
Answer
