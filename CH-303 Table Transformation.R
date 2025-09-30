#https://docs.google.com/spreadsheets/d/1q_vTps3RhrRCtDemBOumQDpHOihIRvWo/edit?gid=437660593#gid=437660593
df <- read_xlsx(File_name,range = "B2:E10")

ValidRows <- function(x) {
  tibble(C = x) |>
    mutate(Index = cumsum(!is.na(C)),
           Valid = sum(!is.na(C)),
           C = case_when(is.na(C) & Index > 1 & Index < Valid ~ ' ',.default = C)) |>
    drop_na() |>
    pull(C)
}

ColumnsCleaned <- apply(df,2,ValidRows) |> as.data.frame()

Answer <- ColumnsCleaned |>
  set_names(ColumnsCleaned[1,]) |>
  slice(-1) |>
  mutate(Date = as.Date(as.numeric(Date), origin = "1899-12-30"))

Answer

