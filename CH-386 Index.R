#https://docs.google.com/spreadsheets/d/1rXb6nhRI3ixzuXO58TRzX1lq7j8AmUFd/edit?gid=1852143531#gid=1852143531

library(tidyverse)
library(readxl)

df <- read_xlsx(File_name, range = "B3:E11")

df |>
  mutate(
    Index = case_when(
      !duplicated(paste0(Customer, Product)) == TRUE ~ "*",
      .default = " "
    ),
    .by = Customer
  )
