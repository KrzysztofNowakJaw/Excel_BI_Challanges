# Link to challange
# https://www.linkedin.com/posts/excelbi_excel-challenge-problem-activity-7227523994650873856-k7Vp?utm_source=share&utm_medium=member_desktop
grades_df <- data.frame(
  Name = c(
    'Dennis',
    'Sara',
    'Elizabeth',
    'Abigail',
    'Carol',
    'Martha',
    'Joseph',
    'Kathryn',
    'Nicholas',
    'Kathleen',
    'Jennifer',
    'Amy',
    'George',
    'Paul',
    'Gabriel',
    'Samuel',
    'Christine',
    'Samantha',
    'Kenneth'
  ),
  Grades = c(
    'F',
    'D',
    'B+',
    'D-',
    'B',
    'A-',
    'F',
    'F',
    'B+',
    'B+',
    'B+',
    'C',
    'A-',
    'A+',
    'D-',
    'C',
    'A-',
    'B',
    'C'
  )
)

grades <- c(
  "A+",
  "A",
  "A-",
  "B+",
  "B",
  "B-",
  "C+",
  "C",
  "C-",
  "D+",
  "D",
  "D-",
  "F"
)
Seq <- 1:13
grades_df$GradesSeq <- factor(grades_df$Grades, levels = grades, labels = Seq)

Answer <- grades_df |>
  mutate(
    GradesSeq = ifelse(GradesSeq != 13, GradesSeq, NA),
    Rank = dense_rank(GradesSeq)
  ) |>
  select(-c(GradesSeq))

Answer
