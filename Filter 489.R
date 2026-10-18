#https://docs.google.com/spreadsheets/d/1hKmXpOWl_Mhrp6PjTIbk4Xp4jLnv2T6_/edit?gid=90678072#gid=90678072
library(DBI)
library(RPostgres)
library(tidyverse)

sql <- 'SELECT 
*
FROM "CH-489 Filter" 
'

df <- dbGetQuery(con, sql)


df |>
  filter(Product == "B") |>
  semi_join(
    df |> filter(Product == "A"),
    join_by(Date == Date, Sales > Sales)
  ) |>
  bind_rows(
    df |>
      group_by(Date) |>
      filter(all(Product == "B"))
  )
