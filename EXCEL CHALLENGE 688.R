#Link to challange:
#https://www.linkedin.com/posts/excelbi_excel-challenge-problem-activity-7313773895931637760-gjAS?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0

library(tidyverse)

# Create a vector of strings
string_values <- c(
  "v8B&5^tM!j9#qZ12",
  "A$9d!W*8k23&Q$oP",
  "*F3x!v^L1231#T$145r",
  "17a78ghfgj8",
  "ydud56gjgudyd",
  "p7@Z#*Q8!v^3rL",
  "gudyieygdgs",
  "&X9^r!5*L@k7T$",
  "110 213 9"
)

# Create a data frame
df <- data.frame(Strings = string_values, stringsAsFactors = FALSE)

# Print the data frame
print(df)

Cleaned <- df |>
  tidytext::unnest_regex(
    input = Strings,
    output = Split,
    pattern = "[^\\d+]",
    drop = FALSE
  ) |>
  mutate(Index = row_number(), Nrows = n(), .by = Strings) |>
  filter(Index > 1 & Index < Nrows)

sum(as.numeric(Cleaned$Split))
