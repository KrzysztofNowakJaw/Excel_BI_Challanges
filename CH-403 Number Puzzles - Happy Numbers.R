#https://docs.google.com/spreadsheets/d/1m6K9t5qWpys13rlpfo3pF5ZHXkPFX0IM/edit?gid=1087373473#gid=1087373473
#https://en.wikipedia.org/wiki/Happy_number

library(tidyverse)

df <- data.frame(
  Number = c(10007, 12345, 70001, 98765, 40007, 11111, 7777777)
)

digital_root <- function(n) {
  NumbersGenerated <- numeric()
  x <- n

  while (x > 1) {
    split <- str_split_1(as.character(x), "")
    UpdatedX <- map_dbl(split, function(d) as.numeric(d)^2) |> sum()

    if (UpdatedX == x || UpdatedX %in% NumbersGenerated) {
      break
    }

    NumbersGenerated <- c(NumbersGenerated, UpdatedX)

    x <- UpdatedX
  }

  return(NumbersGenerated[length(NumbersGenerated)] == 1)
}


map_dbl(df$Number, digital_root)


df$Number |> keep(digital_root)
