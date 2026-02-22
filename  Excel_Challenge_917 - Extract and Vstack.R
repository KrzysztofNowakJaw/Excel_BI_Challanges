#https://onedrive.live.com/:x:/g/personal/e11b26eeaacb7947/IQCCvB_gTZg7SJDVD_vn9W8yAZVzrtjX9G4K81jOyFFr9UE?rtime=-gV0OqVv3kg&redeem=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0lRQ0N2Ql9nVFpnN1NKRFZEX3ZuOVc4eUFaVnpydGpYOUc0Szgxak95RkZyOVVFP2U9SGRaYk1h
library(tidyverse)
library(janitor)
library(EBI)


df <- Excel_Bi_File(from = "A2", to = "E21") |> clean_names()

Comp_case <- df |>
  filter_out(is.na(company)) |>
  select(case_no, company)

df |>
  select(-company) |>
  inner_join(Comp_case) |>
  group_by(case_no) |>
  fill(everything(), .direction = "downup") |>
  mutate(Index = n(), contact = list(contact), .before = 1) |>
  ungroup() |>
  rowwise() |>
  mutate(contact = contact[Index]) |>
  unnest(contact) |>
  summarise(
    Start_Date = min(as.Date(start_date)),
    Finish_Date = max(as.Date(finish_date)),
    .by = c(case_no, company, contact)
  ) |>
  select(case_no, company, Start_Date, Finish_Date, contact) |>
  view()
