#Link to challange
#https://www.linkedin.com/posts/excelbi_excel-challenge-problem-activity-7193821970638000128-AJpt?utm_source=share&utm_medium=member_desktop

library(tidyverse)

df <- data.frame(
  Numbers = c(-4, -1, -1, -1, -3, 4, 2, 2, 2, 2, -3, -3, 5, 5, 5, 5, -1, -1, -1)
)


Changes <- df |>
  mutate(
    Positive = if_else(Numbers > 0, TRUE, FALSE),
    Change = consecutive_id(Positive)
  )

FindTop <- function(Dataset = Data, positive = TRUE) {
  Dataset |>
    filter(Positive == positive) |>
    mutate(Consecutive = consecutive_id(Numbers), .by = Change) |>
    summarise(TopN = n(), .by = c(Change, Numbers)) |>
    slice_max(order_by = TopN, n = 1, with_ties = TRUE) |>
    summarise(
      Numbers = paste(unique(Numbers), collapse = ","),
      Value = paste(unique(TopN), collapse = ",")
    )
}

Positive <- FindTop(Dataset = Changes, positive = TRUE)
Negative <- FindTop(Dataset = Changes, positive = FALSE)
Answer <- bind_rows(Positive, Negative)
Answer
