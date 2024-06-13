#Link to challange
#https://www.linkedin.com/posts/excelbi_excel-challenge-problem-activity-7205780719636213760-Xn2N?utm_source=share&utm_medium=member_desktop

library(tidyverse)
df <- data.frame(Numbers = c(120, 921, 5451, 98431, 354809, 6726389, 89132846, 683687732, 9182736572))

FindWavy <- function(x) {
  
  Nums <- as.numeric(str_split(x, "")[[1]])

  Diffs <- tibble(Split = as.numeric(str_split(x, "")[[1]])) |>
    mutate(
      Index = row_number(),
      Difference = Split - lead(Split),
      Difference = ifelse(is.na(Difference), Split - lag(Split), Difference)
    )

  v <- Diffs$Index

  Evens <- v[seq_along(v) %% n == 0]
  Odds <- v[seq_along(v) %% n != 0]

  AllNegativeEven <- all(Diffs$Difference[Evens] < 0)
  AllPositiveEven <- all(Diffs$Difference[Evens] > 0)
  AllNegativeOdds <- all(Diffs$Difference[Odds] < 0)
  AllPositiveOdds <- all(Diffs$Difference[Odds] > 0)


  if (AllPositiveOdds == TRUE && AllNegativeEven == TRUE || AllNegativeOdds == TRUE && AllPositiveEven == TRUE) {
    TRUE
  } else {
    FALSE
  }
}

Answer <- df$Numbers |>
  keep(\(x) FindWavy(x) == TRUE)
Answer
