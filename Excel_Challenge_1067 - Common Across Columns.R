#https://onedrive.live.com/:x:/g/personal/e11b26eeaacb7947/IQBZlWEzkUq9SbAmun3tzKCIAXjBLCUrWekEuMlP83i349Q?rtime=5BZbfYUU30g&redeem=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0lRQlpsV0V6a1VxOVNiQW11bjN0ektDSUFYakJMQ1VyV2VrRXVNbFA4M2kzNDlRP2U9YlluQXNu
df <- read_xlsx(File_name, range = "A2:E14")

df |>
  pivot_longer(everything(), values_to = "cities", names_to = "columns") |>
  group_by(cities) |>
  arrange(columns) |>
  summarise(
    N = n(),
    Answer = paste(columns, collapse = ", ")
  ) |>
  filter(N > 1 & !is.na(cities)) |>
  arrange(cities)
