#EXCEL CHALLENGE 808
#https://onedrive.live.com/personal/e11b26eeaacb7947/_layouts/15/Doc.aspx?sourcedoc=%7B3b93a475-98cf-4a35-8ded-cdd924f29a02%7D&action=default&redeem=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0VYV2trenZQbURWS2plM04yU1R5bWdJQkE3by05TzNzWVJhNWdKMHM5ZUxwVFE_ZT1yVTZiTUI&slrid=194fc7a1-f0e4-9000-dfcd-7402dbf94f4e&originalPath=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0VYV2trenZQbURWS2plM04yU1R5bWdJQkE3by05TzNzWVJhNWdKMHM5ZUxwVFE_cnRpbWU9Vlc1c0hwajMzVWc&CID=64748368-0d80-42ee-a55d-b0bbf1c31616&_SRM=0:G:46

df <- read_xlsx(File_name, range = "A2:A18")

Answer <- 
df |>
  filter(!str_detect(Data, "\\d+")) |>
  bind_cols(df |> filter(str_detect(Data, "\\d+")) |>
    separate_longer_delim(Data, delim = ", ") |>
    mutate(Weight = as.numeric(Data), .keep = "none")) |>
  summarise(Weight = sum(Weight), .by = Data) |>
  arrange(Data)

Answer
