#https://onedrive.live.com/:x:/g/personal/E11B26EEAACB7947/IQBxqp91B5nMTJ9igD2DYVOBAasnxxix-sAvRSZ-Zqh-vXM?resid=E11B26EEAACB7947!s759faa7199074ccc9f62803d83615381&ithint=file%2Cxlsx&e=ctaJTE&migratedtospo=true&redeem=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0lRQnhxcDkxQjVuTVRKOWlnRDJEWVZPQkFhc254eGl4LXNBdlJTWi1acWgtdlhNP2U9Y3RhSlRF

options(scipen = 999)

library(tidyverse)
library(charcuterie)
library(readxl)

df <- read_xlsx(
  'Excel_Challenge_882 - Reverse Add Palindrome.xlsx',
  col_types = c("numeric", "text")
)


RevFun <- function(x) {
  Base <- as.character(x)
  Base <- str_split_1(Base, "")
  ReversedBase <- as.numeric(string(rev(Base)))

  if (x == ReversedBase) {
    x
  } else {
    RevFun(x + ReversedBase)
  }
}

Answer <- df |>
  mutate(
    MyAnswer = map_dbl(Numbers, RevFun),
    Test = MyAnswer == `Answer Expected`
  )

Answer
