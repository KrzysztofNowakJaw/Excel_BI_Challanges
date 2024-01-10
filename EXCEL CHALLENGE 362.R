#Link to challange:
#https://www.linkedin.com/feed/update/urn:li:activity:7149973012233060353/
# List the numbers where absolute difference between two succeeding digits is 1, 2, 3, 4....sequentially.
# Ex. 3463
# Absolute diff between 2nd and 1st digit = ABS(4-3) = 1
# Absolute diff between 3rd and 2nd digit = ABS(6-4) = 2
# Absolute diff between 4th and 3rd digit = ABS(3-6) = 3 
library(tidyverse)
Numbers <- c(23,457,3608,12473,50874,67584,9887653,98637281,897406182)
Expexted <- c(23,457,12473,67584,98637281)
Task <- data.frame(Numbers = Numbers)
CheckDifferences <- function(x) {
  x <- as.character(x)
  Split <- strsplit(x,"")[[1]]
  Split <- as.numeric(Split)
  Differences <- abs(diff(Split))
  LogicalTest <- diff(Differences)
  Answer <- all(LogicalTest == 1)
  return(Answer)
}
Task |> 
  mutate(Verify = map_lgl(Numbers,CheckDifferences)) |>
  filter(Verify == TRUE)