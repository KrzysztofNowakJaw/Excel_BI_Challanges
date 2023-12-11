library(tidyverse)

Numbers <- c(32,989,40021,43210,764321,1906368,98765321,903363631,9988776655)

df <- data.frame(Numbers = Numbers)

IsKatadrome <- function(x) {
  
  x <- as.character(x)
  Split <- sort(str_split(x,"")[[1]],decreasing = TRUE)
  IsUnique <- sum(duplicated(Split)) == 0
  IsSorted<- paste(sort(str_split(x,"")[[1]],decreasing = TRUE),collapse = "") == x 
  IsUnique & IsSorted

}
  
df |>
  rowwise() |>
  filter(IsKatadrome(Numbers) == TRUE)

#OR

keep(Numbers,IsKatadrome)
