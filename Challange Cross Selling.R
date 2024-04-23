#Link to challenge:
#https://www.linkedin.com/feed/update/urn:li:activity:7187555642771927040?updateEntityUrn=urn%3Ali%3Afs_feedUpdate%3A%28V2%2Curn%3Ali%3Aactivity%3A7187555642771927040%29

library(tidyverse)
library(readxl)

filename <- "CH-040 Cross Selling.xlsx"

df <- read_xlsx(filename,range = "C2:F26") |> janitor::clean_names()
Scenarios <- read_xlsx(filename,range = "H2:H7") |>
  set_names("Scenarios")

SplitStrings <- function(String) {
  Clean <- str_remove_all(String, "[^[A-Z]]")
  Separate <- trimws(str_split(Clean, pattern = "")[[1]])
  print(Separate)
}

FindDifference <- function(x,y) {
  x <- SplitStrings(x)
  y <- SplitStrings(y)
  Diff <- setdiff(x,y)
  Diff <- paste(Diff,collapse = ",")
  return(Diff)
}


CommondData <- 
  df |>
  select(-c("customer_id","quantity")) |>
  group_by(invoice_id) |>
  summarise(Combinations = reduce(product,paste,sep = ",")) |>
  cross_join(Scenarios) |>
  arrange(invoice_id) |>
  rowwise() |>
  mutate(IsCommon = length(Reduce(intersect, list(
    SplitStrings(Combinations),
    SplitStrings(Scenarios)))),
    ScenarioL = str_count(Scenarios,"[A-Z]")) |>
  filter(IsCommon == ScenarioL) |>
  select(Combinations,Scenarios,invoice_id)
  
  Answer <- CommondData |>
    mutate(ToBeCounted = map2_chr(Combinations,Scenarios,FindDifference)) |>
    filter(nchar(ToBeCounted) > 0) |>
    separate_longer_delim(ToBeCounted,delim = ",") |>
    summarise(ComplementaryProductsNumber = n(),.by = c(Scenarios,ToBeCounted)) |>
    slice_max(order_by = ComplementaryProductsNumber,n = 1,by = Scenarios) |>
    slice(1,.by = Scenarios)

Answer[,1:2]
