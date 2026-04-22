#https://onedrive.live.com/:x:/g/personal/E11B26EEAACB7947/IQCMCz-1Ac6LTZ51on5Hxx2lAQpcVPTm3lSKf4f903Ym6Rg?resid=E11B26EEAACB7947!sb53f0b8cce014d8b9e75a27e47c71da5&ithint=file%2Cxlsx&e=uDfEcP&migratedtospo=true&redeem=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0lRQ01Dei0xQWM2TFRaNTFvbjVIeHgybEFRcGNWUFRtM2xTS2Y0ZjkwM1ltNlJnP2U9dURmRWNQ

library(tidyverse)
library(readxl)

df <- read_xlsx(File_name, range = "A1:A15")
Ex <- read_xlsx(File_name, range = "B1:B15")


Max_Len <- function(x) {
  split <- str_split_1(x, "")

  Combinations <- accumulate(split, paste0, .dir = "backward")

  lapply(Combinations, function(x) {
    split <- str_split_1(x, "")

    tibble(
      Values = split,
      IsDup = !duplicated(split),
      Break = cumall(IsDup)
    ) |>
      filter(Break == TRUE) |>
      reframe(Result = paste(Values, collapse = "")) |>
      mutate(N = nchar(Result))
  }) |>
    bind_rows() |>
    slice_max(n = 1, order_by = N, with_ties = TRUE) |>
    distinct() |>
    reframe(Result = paste(Result, collapse = ",")) |>
    pull(Result)
}

df |>
  mutate(My_Answer = map_chr(Text, Max_Len)) |>
  bind_cols(Ex) |>
  mutate(Test = My_Answer == `Answer Expected`) |>
  view()
