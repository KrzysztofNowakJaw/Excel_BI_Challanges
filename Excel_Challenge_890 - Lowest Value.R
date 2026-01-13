library(tidyverse)
library(readxl)

df <- read_xlsx(File_name, range = "B3:D20")

df <- df |>
  mutate(G_Index = as.integer(factor(Area)))

Group_take <- 1

target_n <- length(unique(df$Area))

result <- df[0, ]

Used_Company <- character()

while (Group_take <= target_n) {
  Run <- df |>
    filter(
      G_Index == Group_take,
      !(Company %in% Used_Company)
    ) |>
    slice_min(order_by = Value, n = 1, with_ties = FALSE)

  result <- bind_rows(result, Run)
  Used_Company <- c(Used_Company, Run$Company)

  Group_take <- Group_take + 1
}

result |> view()
