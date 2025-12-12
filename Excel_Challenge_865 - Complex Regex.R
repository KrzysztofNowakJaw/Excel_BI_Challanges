#https://onedrive.live.com/:x:/g/personal/E11B26EEAACB7947/EWDoriV6EiVMrqvPDg46S48BsYMsVB-nNjDcgTk0E_6rUw?resid=E11B26EEAACB7947!s25aee860127a4c25aeabcf0e0e3a4b8f&ithint=file%2Cxlsx&e=WOcU3g&migratedtospo=true&redeem=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0VXRG9yaVY2RWlWTXJxdlBEZzQ2UzQ4QnNZTXNWQi1uTmpEY2dUazBFXzZyVXc_ZT1XT2NVM2c
library(readxl)
library(tidyverse)

df <- read_xlsx(File_name, range = "A2:A95") |> mutate(Index = row_number())

Ex <- read_xlsx(
  File_name,
  range = "C2:E95",
  col_types = c("date", "text", "numeric")
)


DateP <- '2\\d{1,3}[-\\/]\\d{1,2}[-\\/]\\d{1,2}'
ProductID <- '[a-z]{2}\\d{3}'
Weight <- '(\\d+\\s?)(kg?|gms?)|(kg|kgs|gms?)\\s?(\\d+\\s?)'

df$Data <- str_to_lower(df$Data)
Cleaned <- df |>
  mutate(
    Date = str_extract(Data, pattern = DateP),
    ProductID = str_to_upper(str_extract(Data, pattern = ProductID)),
    W = str_extract(Data, pattern = Weight)
  )


Convert <- function(x) {
  W_Table <- tibble(
    Number = as.numeric(str_extract(x, pattern = '\\d+')),
    Unit = str_extract(x, pattern = '[a-z]+')
  )

  Result <- W_Table |>
    mutate(
      Number = case_when(
        str_detect(Unit, "kg") ~ Number,
        .default = Number / 1000
      )
    ) |>
    pull(Number)

  return(Result)
}

Answer <- Cleaned |>
  mutate(
    W_KG = map_dbl(W, Convert),
    Date = parse_date_time(
      Date,
      orders = c("Y-m-d", "Y/m/d", "y-m-d", "Y-m-d")
    )
  ) |>
  select(Date, ProductID, W_KG) |>
  view()

all.equal(Answer, Ex, check.class = FALSE)
