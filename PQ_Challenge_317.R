#https://onedrive.live.com/:x:/g/personal/E11B26EEAACB7947/Ec_V9DXqGRdOt8fXXNqnh9gBgyeFGorFbo4tfEUIM1s3BQ?resid=E11B26EEAACB7947!s35f4d5cf19ea4e17b7c7d75cdaa787d8&ithint=file%2Cxlsx&e=RfgdYn&migratedtospo=true&redeem=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0VjX1Y5RFhxR1JkT3Q4ZlhYTnFuaDlnQmd5ZUZHb3JGYm80dGZFVUlNMXMzQlE_ZT1SZmdkWW4
library(tidyverse)

df <- read_xlsx(File_name, range = "A1:C12")

Cleaned <- df |>
  fill(everything(), .direction = "down") |>
  summarise(Cities = paste(Cities, collapse = ","), .by = c(Country, State)) |>
  pivot_longer(everything(), names_to = c("Data1"), values_to = "Data2")

Cleaned$Data1 <- factor(
  Cleaned$Data1,
  levels = c("Country", "State", "Cities"),
  ordered = TRUE
)

Answer <- Cleaned |>
  unique()

Answer
