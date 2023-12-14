#link to challange
#https://www.linkedin.com/feed/update/urn:li:activity:7141113794155507712/#

# Load the 'tidyverse' package
library(tidyverse)

# Create color data frame
color_df <- data.frame(
  index = c(1, 2),
  color1 = c('red', 'indigo'),
  color2 = c('orange', 'yellow'),
  color3 = c('red', 'blue'),
  color4 = c('blue', 'yellow'),
  color5 = c('violet', 'violet')
)

# Create rnk data frame
rnk_df <- data.frame(
  color = c('Red', 'Orange', 'Yellow', 'Green', 'Blue', 'Indigo', 'Orange', 'Violet'),
  rank = c(1, 2, 3, 4, 5, 6, 7, 8)
)


# Use pivot_longer to reshape color_df
color_df_long <- color_df %>%
  pivot_longer(cols = starts_with("color"), names_to = "color_num", values_to = "color") %>%
  mutate(color = tools::toTitleCase(color))

# Left join color_df_long with rnk_df
result <- left_join(color_df_long, rnk_df, by = c("color" = "color"),multiple = "first")
  

result |>
  arrange(index,rank) |>
  group_by(index) |>
  mutate(rank = row_number(),
         rank = paste0("rank",as.character(rank))) |>
  pivot_wider(id_cols = index,names_from = "rank",values_from = "color") |>
  ungroup() |>
  select(1:4)

