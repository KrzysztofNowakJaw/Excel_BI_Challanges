#https://crispomwangi-my.sharepoint.com/:x:/g/personal/crispo_crispexcel_com/EfeVtNNxSrRFtaESuxw_jvIBR70LBPtd_zatocMbR22KHQ?e=baelSp
library(tidyverse)

#Define dataset source
df <- read_xlsx(File_name, range = "B2:E7")

Answer <- df |>
  rowwise() |> #apply below functions per row
  mutate(
    #Create new column
    across(2:ncol(df), \(x) !is.na(x)), # for every row-column combination after ID return 1 for non NA and 0 for NA
    SumNa = sum(c_across(2:ncol(df)))
  ) |> #Sum NonNA
  filter(SumNa == 0) |> #Filter for 0 sum
  select(1) #Select 1 column

Answer
