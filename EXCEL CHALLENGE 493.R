#Link to challange
#https://www.linkedin.com/posts/excelbi_excel-challenge-problem-activity-7214840461939646464-BJMD?utm_source=share&utm_medium=member_desktop

# Create a data frame
data <- data.frame(
  Index = 1:19,
  Number = c(15, 26, 30, 29, 17, 97, 23, 40, 12, 45, 40, 13, 46, 32, 5, 12, 1, 4, 99)
)


running <- data |>
  mutate(Run =accumulate(Number, ~{if(.x + .y > 100) .y else .x + .y}),
         Test = case_when(Run + lead(Number) > 100  | row_number() == nrow(data) ~ TRUE,.default = FALSE)) 

T <- running |>
  select(Index,Test) |>
  filter(Test == TRUE)

F <- running |>
  filter(Test == FALSE)


Range <- F |>
  left_join(T,join_by(closest(Index < Index))) |>
  select(contains("Index"))


Answer <- running |>
  filter(Test == TRUE) |>
  left_join(Range,by = c("Index" = "Index.y")) |>
  mutate(Index.x = ifelse(is.na(Index.x),Index,Index.x)) |>
  slice_min(Index.x,n = 1,by = Index) |>
  select(Index.x,Index,Run)



