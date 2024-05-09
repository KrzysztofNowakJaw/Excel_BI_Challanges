library(tidyverse)
library(readxl)

filename <- "CH-049 Assignment Problem Part 1.xlsx"

df <- read_xlsx(filename, range = "B2:F6") |> janitor::clean_names()

RowPart <- df |>
  rowwise() |>
  mutate(Lowest = min(c_across(where(is.numeric))),
         across(starts_with("task"),\(x) x -Lowest)) |>
  select(-c(Lowest)) |>
  ungroup()

ColMin <- apply(RowPart[2:ncol(RowPart)], 2, min)

Combined <- bind_rows(RowPart,ColMin) |>
  mutate(across(where(is.numeric),\(x) paste(x,collapse = ",")))

MojaF <- function(x) {
  
  MyList <- x
  Split <- as.numeric(str_split(MyList,",")[[1]]) 
  RemoveLast <- Split[1:length(Split)-1]
  Deductor <- Split[length(Split)]
  ApplyDeduct <- lapply(RemoveLast, function (x) {x - Deductor})
  Result <- paste(ApplyDeduct,collapse = ",")
  return(Result)
}

Deducted <- apply(Combined[2:ncol(Combined)], 2, MojaF) |> as_tibble()

Step2 <- Deducted |>
  mutate(Index = row_number(),.before = value) |>
  pivot_wider(names_from = Index,values_from = value,names_prefix = "Task_") |>
  separate_longer_delim(everything(),delim = ",")

Answer <- df |>
  select(1) |>
  bind_cols(Step2)
