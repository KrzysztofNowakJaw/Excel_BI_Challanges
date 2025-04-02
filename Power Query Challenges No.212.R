#Link to challange
#https://www.linkedin.com/posts/omidmot_powerabrquery-excel-powerabrqueryabrtips-activity-7312579462611513346-1v9p?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0

#R solution

library(tidyverse)

df |>
  pivot_longer(everything()) |>
  group_by(value) |>
  mutate(Count_list = n_distinct(name)) |>
  filter(Count_list == 1) |>
  select(value) |>
  unique()


#Power Query solution

let
 Source = Excel.CurrentWorkbook(){[Name = "Tabela1"]}[Content],
  #"Anulowano przestawienie kolumn" = Table.UnpivotOtherColumns(Source, {}, "Atrybut", "Wartość"),
  #"Pogrupowano wiersze" = Table.Group(#"Anulowano przestawienie kolumn", {"Wartość"}, {{"Liczba", each Table.RowCount(Table.Distinct(_)), Int64.Type}}),
  #"Przefiltrowano wiersze" = Table.SelectRows(#"Pogrupowano wiersze", each ([Liczba] = 1))

 in #"Przefiltrowano wiersze"
