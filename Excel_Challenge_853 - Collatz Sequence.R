#https://onedrive.live.com/personal/e11b26eeaacb7947/_layouts/15/Doc.aspx?sourcedoc=%7B14af465c-0397-4214-bb2b-18188e3608e5%7D&action=default&redeem=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0VWeEdyeFNYQXhSQ3V5c1lHSTQyQ09VQlBVQkhLZjhUZ1g1MVJnOGV2bmowclE_ZT16ZTluQlE&slrid=4684dba1-80fc-0000-1289-f45412a69fc1&originalPath=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0VWeEdyeFNYQXhSQ3V5c1lHSTQyQ09VQlBVQkhLZjhUZ1g1MVJnOGV2bmowclE_cnRpbWU9NjhXRjhlMG8za2c&CID=0aa8aee7-9564-4d23-bb33-3c26a1298ec1&_SRM=0:G:38

library(tidyverse)
library(janitor)


df <- read_xlsx(File_name, range = "A2:C9") |> clean_names()


CollatzSeq <- function(Base) {
  Collatz <- numeric()

  while (Base != 1) {
    if (Base %% 2 == 0) {
      Base <- Base / 2
    } else {
      Base <- Base * 3 + 1
    }
    Collatz <- c(Collatz, Base)
  }

  return(length(Collatz))
}


df |>
  select(1, 2) |>
  mutate(Answer = map_int(start_number, CollatzSeq)) |>
  view()
