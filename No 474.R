#https://www.linkedin.com/in/omidmot/recent-activity/all/
library(readxl)
library(tidyverse)

df <- read_xlsx(File_name, range = "B3:D11")
Expected <- read_xlsx(File_name, range = "G3:G11")

replaceX <- function(x) {
  Split <- str_split_1(x, pattern = "")

  LastX <- which(Split == 'X') |> max()

  Split[LastX] <- '-'

  Answer <- paste(Split, collapse = "")

  return(Answer)
}

Answer <- df |>
  mutate(`Product ID` = map_chr(`Product ID`, replaceX))

Answer

Answer$`Product ID` == Expected$`Product ID`
