library(tidyverse)
library(tidytext)
library(readxl)


df <- read_xlsx(
  'Excel_Challenge_856 - Capitalize Consonants Around Vowels.xlsx'
) |>
  janitor::clean_names()

Cap_Pos <- function(x) {
  vow <- c('a', 'e', 'i', 'o', 'u')
  Split <- str_split_1(x, "")

  CapPos <- sort(c(
    which(Split %in% vow) + 1,
    which(Split %in% vow) - 1
  ))

  Replace <- map(Split[CapPos], function(x) {
    if (!(x %in% vow)) {
      str_to_upper(x)
    } else {
      x
    }
  })

  Split[CapPos] <- Replace |> unlist()
  Result <- paste(na.omit(Split), collapse = "")
  return
  Result
}

df |>
  unnest_tokens(
    input = authors,
    output = words,
    token = "regex",
    pattern = "[^A-Za-zÀ-ž\\.]+",
    to_lower = FALSE,
    drop = FALSE
  ) |>
  mutate(Capitalized = map_chr(words, Cap_Pos)) |>
  summarise(
    Result = paste(Capitalized, collapse = " "),
    .by = c(authors, expected_answer)
  ) |>
  mutate(Test = Result == expected_answer) |>
  select(authors, Result, expected_answer, Test) |>
  view()
