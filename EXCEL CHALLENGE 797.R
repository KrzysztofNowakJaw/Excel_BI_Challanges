library(tidyverse)
library(gt)


Cages <- read_xlsx(File_name, range = "A2:A6")
Animals <- read_xlsx(File_name, range = "B2:B36")

IndexTable <- Cages |>
  separate_wider_delim(Cage, delim = ', ', names = c("Cage", "Base")) |>
  uncount(as.numeric(Base))


Answer <- IndexTable |>
  bind_cols(Animals |> head(nrow(IndexTable))) |>
  mutate(
    Cage = case_when(row_number() == 1 ~ Cage, .default = NA),
    .by = Cage
  ) |>
  select(Cage, Animals)
