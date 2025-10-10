#Link to challange
#https://www.linkedin.com/posts/omid-motamedisedeh-74aba166_excelchallenge-powerquerychllenge-excel-activity-7201326372399554560-pza3?utm_source=share&utm_medium=member_desktop
library(tidyverse)
library(readxl)


filename <- "CH-059 Merge Columns.xlsx"

df <- read_xlsx(filename, range = "B2:J12")
Expected <- read_xlsx(filename, range = "L2:P12")

Pivoted <- df |>
  pivot_longer(cols = 2:ncol(df)) |>
  mutate(
    Index = as.numeric(str_extract(name, "\\d+")),
    Index = Index %% 3,
    Index = consecutive_id(Date, Index)
  ) |>
  summarise(Answer = sum(value), .by = c("Date", "Index"))

Pivoted <- Pivoted |>
  mutate(Index = Index %% 4) |>
  pivot_wider(id_cols = Date, names_from = Index, values_from = Answer)

names(Pivoted) <- c("Date", "E_0000", "E_0100", "E_0200", "E_0300")

all.equal(Pivoted, Expected)
