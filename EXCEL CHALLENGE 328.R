library(tidyverse)
library(readxl) 

df <- read_xlsx("Remove Minimum.xlsx",range = "A1:A7")


RemoveLastMin <- function(x) {
  
  NumberConversion <- as.numeric(unlist(str_split(x,",")))
  
  min_value <- min(NumberConversion)
  
  which(NumberConversion == min_value)
  
  last_index <- tail(which(NumberConversion == min_value), 1)
  
  RemoveIndex <- NumberConversion[-last_index]
  
  result <- paste(unlist(str_split(RemoveIndex," ")),collapse = ",")
  
  print(result)
}


Answer <- df$Answer <- sapply(df$String,RemoveLastMin)

df
