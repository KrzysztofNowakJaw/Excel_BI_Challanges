#Link to challange
#https://www.linkedin.com/posts/excelbi_challenge-powerquerychallenge-daxchallenge-activity-7189835669022621696-9uif?utm_source=share&utm_medium=member_desktop

# Library Loading
pacman::p_load(tidyverse,readxl,gt,DT)

filename <- "PQ_Challenge_177.xlsx"

df <- read_xlsx(filename, range = "A1:F10")

IsBigger <- function(x) {
  x > 40 
}

RowWiseSummary <- df |>
  rowwise() |>
  mutate(
    Total_Marks = sum(c_across(starts_with("Marks"))),
    Result = all(IsBigger(c_across(starts_with("Marks")))),
    Result = if_else(Result == TRUE,"Pass","Fail")) |>
    ungroup()

Ranks <- RowWiseSummary |>
  summarise(Mean = mean(Total_Marks),.by = Name) |>
  mutate(Rank = dense_rank(desc(Mean))) 

Answer <- RowWiseSummary |>
  left_join(Ranks,by = "Name") |>
  select(c("Name","Classs","Subject","Total_Marks","Result","Rank")) |>
  mutate(Name = if_else(row_number() > 1,NA,Name),
         Rank = if_else(row_number() > 1,NA,Rank),
         Classs = if_else(row_number() > 1,NA,Classs)
         ,.by = Name)

Answer |>
  gt() |>
  sub_missing(everything(),missing_text = "") |>
  opt_stylize(style = 3,color = "blue")

