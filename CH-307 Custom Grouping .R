#https://www.linkedin.com/posts/omidmot_exclude-powerabrquery-excel-activity-7381433168786231297-S_IY?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0
library(tidyverse)

df <- read_xlsx(File_name, range = "B2:C19")

data.frame(
    Group = c(1, 2),
    Values = c(
        sum(df$Sales[c(TRUE, FALSE)]),
        sum(df$Sales[c(FALSE, TRUE)])
    )
)

#If v has more than two elements, then the indexing vector is too short.
#Hence, R will invoke the Recycling Rule and expand the index vector to the length of v, recycling its contents.
#That gives an index vector that is FALSE, TRUE, FALSE, TRUE, FALSE, TRUE, and so forth.
#Voilà! The final result is every second element of v.
#James (JD) Long, Paul Teetor - R Cookbook, 2nd Edition
