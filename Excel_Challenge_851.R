#https://onedrive.live.com/personal/e11b26eeaacb7947/_layouts/15/Doc.aspx?sourcedoc=%7Bfcc477a9-4a94-4234-86fa-d96728cc3b4f%7D&action=default&redeem=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0VhbDN4UHlVU2pSQ2h2clpaeWpNTzA4QkYzVEM3OTFlS2ZINkR3REloUEE0dXc_ZT1mSWh4aXM&slrid=0feadaa1-a0ac-0000-017a-1e50761300ca&originalPath=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0VhbDN4UHlVU2pSQ2h2clpaeWpNTzA4QkYzVEM3OTFlS2ZINkR3REloUEE0dXc_cnRpbWU9OFVKcWNIVW4za2c&CID=165ec36f-bb87-4dac-a329-e1d5cf9cca26&_SRM=0:G:40

library(tidyverse)

tabela <- data.frame(
  Data = c(
    "Marketing",
    "Thomas",
    "Russell",
    "Emily",
    "===============",
    "IT",
    "Karen",
    "Shirley",
    "Lawrence",
    "===============",
    "HR",
    "Christian",
    "===============",
    "Purchasing",
    "Olivia",
    "Billy",
    "Lisa",
    "Megan"
  ),
  stringsAsFactors = FALSE
)

Transposed <- tabela |>
  mutate(test = cumsum(Data == '===============')) |>
  filter(Data != '===============') |>
  group_by(test) |>
  mutate(Dep = case_when(row_number() == 1 ~ Data, .default = NA)) |>
  fill(Dep, .direction = "down") |>
  filter(Data != Dep) |>
  ungroup() |>
  select(-c(test)) |>
  pivot_wider(names_from = Dep, values_from = Data, values_fn = list)

TotalLength <- function(Table) {
  TL <- max(apply(Table, 2, function(x) {
    length(x[[1]])
  }))

  return(TL)
}

AlignList <- function(x) {
  x <- x[[1]]
  TotalLenght <- TL

  return
  c(x, rep(NA, TotalLenght - length(x)))
}


Answer <- apply(Transposed, 2, AlignList) |> as.data.frame()
