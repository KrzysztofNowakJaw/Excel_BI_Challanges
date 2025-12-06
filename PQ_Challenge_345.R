#https://onedrive.live.com/:x:/g/personal/E11B26EEAACB7947/EVcvoQdFMApHozdz2Db9XsMBnps7lALMeBuxZOSgxSOsfA?resid=E11B26EEAACB7947!s07a12f573045470aa33773d836fd5ec3&ithint=file%2Cxlsx&e=O5iywF&migratedtospo=true&redeem=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0VWY3ZvUWRGTUFwSG96ZHoyRGI5WHNNQm5wczdsQUxNZUJ1eFpPU2d4U09zZkE_ZT1PNWl5d0Y
library(tidyverse)
library(readxl)
library(janitor)
library(glue)

df <- read_xlsx(File_name, range = "A1:G31")

Cleaned <- df |>
  mutate(
    RegionFlag = case_when(
      str_detect(Column1, "Region") ~ str_extract(
        Column1,
        '(Region:\\s)(.+)',
        group = 2
      ),
      .default = NA
    ),
    .before = 1
  ) |>
  fill(RegionFlag, .direction = "down") |>
  filter(!str_detect(Column1, "Region")) |>
  clean_names() |>
  mutate(Period = cumsum(str_detect(column1, "Category")))

Pivoted <- Cleaned |>
  group_split(Period, .keep = FALSE) |>
  map(\(df) {
    df |>
      row_to_names(1) |>
      pivot_longer(3:8) |>
      rename(Region = 1)
  }) |>
  bind_rows() |>
  separate_wider_delim(name, delim = "-", names = c("Month", "Operation")) |>
  rowwise() |>
  mutate(
    Quarter = as.Date(
      glue("01", str_to_title(Month), "1990", .sep = "-"),
      format = "%d-%b-%Y"
    ),
    Quarter = paste("Q", quarter(Quarter), sep = "")
  ) |>
  select(-Month) |>
  ungroup()

SalesReturn <- Pivoted |>
  summarise(
    OperationSum = sum(as.numeric(value)),
    .by = c(Region, Quarter, Operation)
  ) |>
  pivot_wider(
    id_cols = c(Region, Quarter),
    names_from = Operation,
    names_prefix = "Total_",
    values_from = OperationSum,
    values_fn = list
  ) |>
  unnest(3:4)

Ranking <- Pivoted |>
  summarise(
    OperationSum = sum(as.numeric(value)),
    .by = c(Region, Quarter, Operation, Category)
  ) |>
  mutate(
    Dens = dense_rank(desc(OperationSum)),
    .by = c(Region, Quarter, Operation)
  ) |>
  filter(Dens == 1) |>
  summarise(
    Operations = paste(Category, collapse = ","),
    .by = c(Region, Quarter, Operation)
  ) |>
  pivot_wider(
    id_cols = c(Region, Quarter),
    names_from = Operation,
    values_from = Operations,
    names_prefix = "Max_"
  ) |>
  arrange(Region)

SalesReturn |>
  left_join(Ranking, by = c("Region", "Quarter")) |>
  arrange(desc(Region)) |>
  view()
