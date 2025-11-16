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
