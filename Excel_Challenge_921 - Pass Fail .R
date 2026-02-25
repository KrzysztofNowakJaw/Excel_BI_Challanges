#https://onedrive.live.com/:x:/g/personal/e11b26eeaacb7947/IQAM3CvPnAHpQ5q9FDazuKDKARKxvwO0WZvZWupZ-y-3IPc?rtime=puOHHFl03kg&redeem=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0lRQU0zQ3ZQbkFIcFE1cTlGRGF6dUtES0FSS3h2d08wV1p2Wld1cFoteS0zSVBjP2U9cmZZeVNx
library(tidyverse)
library(readxl)
library(janitor)


Table1 <- read_xlsx(File_name, range = "A1:C16") |> clean_names()
Table2 <- read_xlsx(File_name, range = "E1:F6") |> clean_names()

Expected <- read_xlsx(File_name, range = "E10:G13") |> clean_names()

Answer <- Table1 |>
  inner_join(Table2, join_by(subject == subject, marks >= passing_marks)) |>
  mutate(Label = 'Pass') |>
  bind_rows(
    Table1 |>
      inner_join(Table2, join_by(subject == subject, marks < passing_marks)) |>
      mutate(Label = 'Fail')
  ) |>
  summarise(
    Un_Pass_Subjects = paste(subject, collapse = ', '),
    .by = c(student, Label)
  ) |>
  pivot_wider(
    id_cols = student,
    names_from = Label,
    values_from = Un_Pass_Subjects,
    names_prefix = "Subjects "
  )

Answer |>
  view()
