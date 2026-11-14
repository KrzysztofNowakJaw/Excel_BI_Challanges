#https://onedrive.live.com/:x:/g/personal/E11B26EEAACB7947/IQAFrIbkhG5SSqvNYtiMDOK0AVwmnEaAzXN0c-HedGI9Uqs?resid=E11B26EEAACB7947!se486ac056e844a52abcd62d88c0ce2b4&ithint=file%2Cxlsx&e=yhtVp3&migratedtospo=true&redeem=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0lRQUZySWJraEc1U1Nxdk5ZdGlNRE9LMEFWd21uRWFBelhOMGMtSGVkR0k5VXFzP2U9eWh0VnAz

library(tidyverse)
library(readxl)


df <- read_xlsx(File_name, range = "A1:A6")

Week <- weekdays(as.Date("2017-01-01") + 1:7, TRUE) # Mon, Tue, ..., Sun


Base_Table <- df |>
  separate_wider_delim(
    cols = Data,
    delim = " | ",
    names = c("Order", "Type", "Freq", "Window")
  ) |>
  separate_longer_delim(Freq, delim = ",") |>
  mutate(
    Freq = str_remove(Freq, "Freq: "),
    Window = str_remove(Window, "Window: "),
    Q = case_when(Freq == "Daily" ~ 7, .default = 1)
  ) |>
  uncount(Q)


Base_Table |>
  filter(Freq == "Daily") |>
  mutate(Freq = dni[1:7]) |>
  bind_rows(
    Base_Table |>
      filter_out(Freq == "Daily")
  ) |>
  arrange(match(Freq, Week), Type, Window) |>
  select(Freq, Type, Window, -Order)
