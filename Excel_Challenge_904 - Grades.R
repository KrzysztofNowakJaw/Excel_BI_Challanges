#https://www.linkedin.com/posts/excelbi_excel-challenge-problem-activity-7423938280259342336-io_J?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0
library(EBI)
library(tidyverse)

df <- Excel_Bi_File(from = "A1", to = "B21")

Cleaned <- df |>
  separate_longer_delim(`Subject Marks`, delim = '; ') |>
  separate_wider_delim(
    cols = `Subject Marks`,
    delim = ':',
    names = c("Subject", "Grade")
  ) |>
  mutate(Grade = as.numeric(Grade))

F_Students <- Cleaned |>
  filter(cumsum(Grade < 60) >= 2, .by = Student_ID) |>
  summarise(Grade = "F", .by = Student_ID)

Answer <- Cleaned |>
  filter(!(Student_ID %in% F_Students$Student_ID)) |>
  slice_max(n = 3, by = Student_ID, order_by = Grade, with_ties = TRUE) |>
  summarise(Average = mean(as.numeric(Grade)), .by = Student_ID) |>
  mutate(
    Grade = case_when(
      Average >= 90 ~ "A",
      Average >= 80 ~ "B",
      Average >= 70 ~ "C",
      Average >= 60 ~ "D",
      Average < 60 ~ "F"
    ),
    .keep = "unused"
  ) |>
  bind_rows(F_Students) |>
  arrange(Student_ID)

Answer
