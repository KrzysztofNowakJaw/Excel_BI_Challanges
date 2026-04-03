#https://onedrive.live.com/:x:/g/personal/E11B26EEAACB7947/IQA2z_tUkDDhQI1p6TW-XS8vAYMrkJKWghi20J3VLSORb2Y?resid=E11B26EEAACB7947!s54fbcf36309040e18d69e935be5d2f2f&ithint=file%2Cxlsx&e=Os8IxR&migratedtospo=true&redeem=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0lRQTJ6X3RVa0REaFFJMXA2VFctWFM4dkFZTXJrSktXZ2hpMjBKM1ZMU09SYjJZP2U9T3M4SXhS

library(tidyverse)
library(readxl)

df <- read_xlsx(File_name, range = "A1:A15")

Clean_Seq <- function(L) {
  Pattern <- '(.)\\1'
  if (str_count(L, Pattern) == 0) {
    return(L)
  } else {
    Clean_Seq(str_remove(L, Pattern))
  }
}


df |>
  mutate(Result = map_chr(Data, Clean_Seq)) |>
  view()
