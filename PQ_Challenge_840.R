#https://onedrive.live.com/personal/e11b26eeaacb7947/_layouts/15/Doc.aspx?sourcedoc=%7B840f782d-ee81-4262-a26b-6a851321f085%7D&action=default&redeem=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0VTMTRENFNCN21KQ29tdHFoUk1oOElVQlJ2NnBIZkdITS0tSkU4NkdmckV4aGc_ZT1XRGE0bzc&slrid=04e5d9a1-3060-a000-b031-60d249eb0684&originalPath=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0VTMTRENFNCN21KQ29tdHFoUk1oOElVQlJ2NnBIZkdITS0tSkU4NkdmckV4aGc_cnRpbWU9RzJyWEhfZ2sza2c&CID=89096ecc-6409-4f8c-9cb9-17448cb3fa18&_SRM=0:G:41
df <- read_xlsx(File_name, range = "A1:B16")

Sums <- df |>
  summarise(Revenue = sum(Revenue), .by = Group) |>
  arrange(desc(Revenue))

Sums |>
  cross_join(Sums) |>
  filter(Group.x != Group.y) |>
  mutate(Diff = abs(Revenue.x - Revenue.y)) |>
  arrange(Group.x, Diff) |>
  filter(dense_rank(Diff) == 1, .by = Group.x) |>
  summarise(
    `Next Nearest Group` = paste(Group.y, collapse = ","),
    `Next Nearest Group Revenue` = max(Revenue.y),
    .by = Group.x
  ) |>
  rename(Group = Group.x) |>
  view()

#SQL
