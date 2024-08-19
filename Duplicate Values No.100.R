#Link to challange
#https://www.linkedin.com/posts/omid-motamedisedeh-74aba166_powerabrquery-excel-powerabrqueryabrtips-activity-7231404560697765891-XwKU?utm_source=share&utm_medium=member_desktop
library(tidyverse)

product_ids <- c(100, 100, 102, 103, 107, 107, 107, 107, 108, 108, 108, 108, 109)

df <- data.frame(Product_ID = product_ids)

Answer <- df |>
  summarise(Count = n(), .by = Product_ID) |>
  group_by(Product_ID) |>
  complete(Count = seq(from = 1, to = Count, by = 1)) |>
  mutate(IsDup = n()) |>
  mutate(
    Result =
      ifelse(IsDup > 1,
        str_c(as.character(Product_ID), LETTERS[Count], sep = ""),
        as.character(Product_ID)
      )
  )

data.table::data.table(Answer)
