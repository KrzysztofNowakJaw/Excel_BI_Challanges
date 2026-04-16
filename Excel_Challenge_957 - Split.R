#https://www.linkedin.com/posts/excelbi_excel-challenge-problem-activity-7450392545299193856-OeXr?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0

df <- read_xlsx(File_name) |> select(1, 2)
Ex <- read_xlsx(File_name) |> select(3)

df <- df |>
  mutate(
    Index = row_number(),
    Positions = str_extract_all(Split_Rules, "\\d+"),
    Rule = str_extract(Split_Rules, "@[A-Z]+"),
    .keep = "unused"
  )

Apply_Rule <- function(Expression, Positions, Rule) {
  split <- str_split_1(Expression, "")
  PositionU <- as.integer(unlist(Positions))
  split[PositionU] <- lapply(split[PositionU], function(x) paste0(x, " | "))

  Numbers <- switch(
    Rule,
    "@DIGIT" = which(str_detect(split, "\\d")),
    "@UPPER" = which(str_detect(split, "[A-Z]")),
    "@ALPHA" = which(str_detect(split, "[A-Za-z]"))
  )

  split[Numbers] <- lapply(split[Numbers], function(x) {
    paste0(" | ", x)
  })

  split <- str_replace_all(
    paste(split, collapse = ""),
    pattern = '\\|\\s+\\|',
    replacement = '|'
  )
}

Answer <- df |>
  group_split(Index) |>
  map(\(d) {
    mutate(
      d,
      Solution = Apply_Rule(Data, Positions[[1]], Rule),
      .keep = "unused"
    )
  }) |>
  bind_rows() |>
  mutate(Solution = str_remove(Solution, '^\\s\\|\\s'))

Answer |>
  view()
