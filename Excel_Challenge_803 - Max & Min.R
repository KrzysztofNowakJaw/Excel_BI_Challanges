#https://onedrive.live.com/personal/e11b26eeaacb7947/_layouts/15/Doc.aspx?sourcedoc=%7Bac9649cf-15bd-4dfc-b33f-45ca1bc9c4d8%7D&action=default&redeem=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0VjOUpscXk5RmZ4TnN6OUZ5aHZKeE5nQmNpUk9TMjJkVEgwdkVKVlB0bFFFLXc_ZT1pWjhtaDU&slrid=0c06c5a1-0053-9000-dfcd-78f40b25e9bd&originalPath=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0VjOUpscXk5RmZ4TnN6OUZ5aHZKeE5nQmNpUk9TMjJkVEgwdkVKVlB0bFFFLXc_cnRpbWU9ZmxGbHhBUHkzVWc&CID=7795b713-b654-4dbe-96f8-6d202d5c46ee&_SRM=0:G:46
df <- read_xlsx(File_name,range = "A2:I7") 

Max <- as.matrix(df[2:ncol(df)]) |> max()
Min <- as.matrix(df[2:ncol(df)]) |> min()

df |>
  pivot_longer(!Name,names_to = "Year", values_to = "value") |>
  filter(value %in% c(Max,Min)) |>
  arrange(desc(value)) |>
  mutate(Index = row_number(),
        Category = case_when(value == Max & Index == 1 ~ "Max",
                             value == Min & Index == 1 ~ "Min"
                 ,.default = NA)
        ,.by = value) |>
  select(Category,Name,Year)

