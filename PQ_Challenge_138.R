#Link to challenge:
#https://www.linkedin.com/feed/update/urn:li:activity:7139463742718746624/

library(tidyverse)
library(readxl) 


#Load Data
df <- read_xlsx("PQ_Challenge_138.xlsx", range = "A1:F9")


Letters <- Pivoted |>
  filter(str_detect(value,"[A-Z]") == TRUE) |>
  mutate(Index = rep(1:2, length.out = n()),
         combined = paste(Index,value,sep = "-")) |>
  pivot_wider(names_from = "Index", values_from = "combined", names_prefix = "Group") |>
  mutate(Group2 = lead(Group2),
         across(contains("Group"), \(x) str_remove_all(x,"\\d|-"))) |>
  filter(!is.na(Group1)) |>
  select(contains("Group"))


Numbers <- Pivoted |>
  filter(str_detect(value,"\\d{1}") == TRUE) |>
  mutate(Index = rep(1:2, length.out = n()),
         combined = paste(Index,value,sep = "-")) |>
  pivot_wider(names_from = "Index", values_from = "combined", names_prefix = "Value") |>
  mutate(Value2 = lead(Value2),
         across(contains("Value"), \(x) str_remove_all(x,"^\\d-"))) |>
  filter(!is.na(Value1)) |>
  select(Value1,Value2)



Result <- bind_cols(Letters,Numbers)
