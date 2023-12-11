#Link to challenge
#https://www.linkedin.com/search/results/content/?fromMember=%5B%22ACoAAByBXHwBWbdpEpS1fnfvxD21zkOGmmhNQWU%22%5D&heroEntityKey=urn%3Ali%3Afsd_profile%3AACoAAByBXHwBWbdpEpS1fnfvxD21zkOGmmhNQWU&keywords=Excel%20BI&sid=F5l&update=urn%3Ali%3Afs_updateV2%3A(urn%3Ali%3Aactivity%3A7139826139807608832%2CBLENDED_SEARCH_FEED%2CEMPTY%2CDEFAULT%2Cfalse)

library(tidyverse)

Numbers <- c(32,989,40021,43210,764321,1906368,98765321,903363631,9988776655)

df <- data.frame(Numbers = Numbers)

IsKatadromeTwo <- function(x) {
  
  x <- as.character(x)
  digits <- as.numeric(unlist(str_split(x,"")))
  return(all(diff(digits) < 0 ))
}
  
Answer <- df |>
  rowwise() |>
  filter(IsKatadromeTwo(Numbers) == TRUE)

Answer

