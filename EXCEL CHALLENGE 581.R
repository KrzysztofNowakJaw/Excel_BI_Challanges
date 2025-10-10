#Link to challange
#https://www.linkedin.com/posts/excelbi_excel-challenge-problem-activity-7259776530250092545-vV6s?utm_source=share&utm_medium=member_desktop

library(tidyverse)
library(readxl)

df <- read_excel(my_files, range = 'A1:A18')

Indexes <- consecutive_id(df$Column1)

Zeros <- which(is.na((df$Column1)))

Indexes[Zeros] <- 0

AspositionsOverOne <- consecutive_id(Indexes[Indexes > 0])

Indexes[Indexes > 0] <- AspositionsOverOne

df$Answer <- Indexes

df
