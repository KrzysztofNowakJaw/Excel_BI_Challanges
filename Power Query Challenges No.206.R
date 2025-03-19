library(tidyverse)

Problem <- c(
  'A1B2C3',
  'MNXLP',
  'QRW32',
  'X1Y2Z3',
  '89A6B4'
)

EvenOdd <- function(x) { 

Split <- str_split(x,"")[[1]]

Characters <- length(Split)

Seq <- seq(from = 1,to = Characters,by = 1)

EvenIndices <- which(Seq %% 2 == 0)
OddIndices <- which(Seq %% 2 != 0)

Even <- paste(Split[EvenIndices],collapse = "")
Odd <- paste(Split[OddIndices],collapse = "")

#tibble(Odd = Odd,
 #      Even = Even)
}

Answer <- map_df(Problem,EvenOdd)
Answer
