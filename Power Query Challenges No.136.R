#Link to challange
#https://www.linkedin.com/posts/omid-motamedisedeh-74aba166_powerabrquery-excel-powerabrqueryabrtips-activity-7257496514585919488-Neqy?utm_source=share&utm_medium=member_desktop

library(tidyverse)

df <- tibble(Id = c('MXNN1',
            'FFF12',
            'RSN',
            'HNNM',
            'RQ1221',
            'O22OO'))


df

Groups <- function(X) {
  
X <- str_split(X,'')[[1]]

group <- 1
Index <- numeric(length(X)) 

Index[1] <- group 

for (i in 2:length(X)) { 
  if (X[i] != X[i - 1]) {
    Index[i] <- group
  } else {
    group <- group + 1 
    Index[i] <- group
  }
}
return(Index)
}

Answer <- df |>
  mutate(Groups = map(Id,Groups)) |>
  unnest_longer(everything()) |>
  mutate(Index = row_number()
         ,.by = Id) |>
  mutate(Elements = paste(substr(Id,Index,Index),collapse = ""),.by = c(Id,Groups)) |>
  select(-c(Index)) |>
  unique() |>
  pivot_wider(names_from = Groups,values_from = Elements,names_prefix = 'ID.') |>
  select(-c(Id))

Answer

  
  

         