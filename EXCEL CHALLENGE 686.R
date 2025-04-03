#link to challange
#https://www.linkedin.com/posts/excelbi_excel-challenge-problem-activity-7313047546849849344-ZaKL?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0


Answer <- df |>
  arrange(EmpCode,Date) |>
  mutate(Change = consecutive_id(EmpCode,Role)) |>
  summarise(Min = format(min(Date),"%b%y"),
            Max =  format(max(Date),"%b%y"),
            .by = c(EmpCode,Role,Change)) |>
  mutate(Max = case_when(Min == Max ~ NA,.default = Max),
         Period = case_when(is.na(Max) ~ Min,.default = paste(Min,Max,sep = " to "))) |>
  summarise(Period = paste(Period,collapse = ","),.by = c(EmpCode,Role)) |>
  pivot_wider(id_cols = Role,names_from = EmpCode,values_from = Period) |>
  arrange(Role)

