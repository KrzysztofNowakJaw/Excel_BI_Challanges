#https://docs.google.com/spreadsheets/d/1cmOSt2s1k6ESYlaDZ98emTtGbLdmhMz5/edit?gid=227598293#gid=227598293
library(tidyverse)

df <- data.frame(
  ID = c(
    "MN11T1Q",
    "MNQwMM1",
    "FGFFGG",
    "FSSSMMS",
    "Q1234",
    "MNMNN",
    "MNA"
  ),
  stringsAsFactors = FALSE
)

FindDuplicate <- function(x) {
  Last <- str_extract(x, ".$")
  Remove <- str_remove_all(x, Last)
  chars <- str_split_1(Remove, "")
  duplicates <- chars[duplicated(chars)]
  length(duplicates) >= 2
}


df$ID |> keep(FindDuplicate)
