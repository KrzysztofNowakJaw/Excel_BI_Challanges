#https://onedrive.live.com/:x:/g/personal/E11B26EEAACB7947/IQDTYjjUOeizQJkG3C6RVzX-AQ_QVkkLPYYVOhBqpiGbQC4?resid=E11B26EEAACB7947!sd43862d3e83940b39906dc2e915735fe&ithint=file%2Cxlsx&e=7lSb5M&migratedtospo=true&redeem=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0lRRFRZampVT2VpelFKa0czQzZSVnpYLUFRX1FWa2tMUFlZVk9oQnFwaUdiUUM0P2U9N2xTYjVN

codes <- c(
  "AB",
  "BC",
  "CD",
  "DE",
  "EF",
  "ZX",
  "XY",
  "YZ",
  "LM",
  "MN",
  "NO",
  "OP",
  "PQ",
  "QR",
  "RS",
  "ST",
  "TU",
  "UV",
  "VA",
  "AB",
  "YZ",
  "GH",
  "HI",
  "IJ",
  "JK",
  "KL"
)

df <- data.frame(Code = codes)

Indexed <- df |>
  mutate(
    Index = row_number(),
    First = str_extract(Code, '^[A-Z]{1}'),
    Last = str_extract(Code, '[A-Z]{1}$')
  )


Answer <- Indexed |>
  left_join(Indexed, join_by(Last == First, Index < Index)) |>
  arrange(desc(Index.x)) |>
  mutate(Group = cumsum(is.na(Code.y))) |>
  arrange(Index.x) |>
  unique() |>
  summarise(
    First = first(First),
    Last = paste(Last, collapse = ""),
    .by = Group
  ) |>
  mutate(Answer = paste(First, Last, sep = "")) |>
  select(Answer)


Answer
