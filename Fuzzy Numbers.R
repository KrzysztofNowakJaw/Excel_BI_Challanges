#Link to challange
#https://www.linkedin.com/posts/omid-motamedisedeh-74aba166_excelchallenge-powerquerychllenge-excel-activity-7199876815606210560-F1-7?utm_source=share&utm_medium=member_desktop


library(tidyverse)
library(readxl)

filename <- "CH-57 Fuzzy Numbers Calculation.xlsx"

df <- read_xlsx(filename, range = "B2:C15")
Expected <- read_xlsx(filename, range = "G2:H15")

Adding <- function(x, y, Sign = "+") {
  A <- as.numeric(str_extract_all(x, "\\d+")[[1]])
  B <- as.numeric(str_extract_all(y, "\\d+")[[1]])
  MatrixA <- matrix(A)
  MatrixB <- matrix(B)

  # Perform the operation based on the Sign argument
  result <- switch(Sign,
    "+" = MatrixA + MatrixB,
    "-" = c(MatrixA[1] - MatrixB[3], MatrixA[2] - MatrixB[2], MatrixA[3] - MatrixB[1]),
    stop("Invalid operator specified.")
  )

  Add <- paste(result, collapse = ",")
  return(Add)
}

Answer <- df |>
  mutate(
    Adding = map2_chr(A, B, ~ Adding(.x, .y, Sign = "+")),
    Substracting = map2_chr(A, B, ~ Adding(.x, .y, Sign = "-"))
  )

Answer |>
  bind_cols(Expected) |>
  mutate(Test = Adding == `A+B` & Substracting == `A-B`)
