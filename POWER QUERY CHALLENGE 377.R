#https://www.linkedin.com/posts/excelbi_challenge-powerquerychallenge-daxchallenge-activity-7443507159746891776-3cub?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0

df <- read_xlsx(File_name, range = "A1:D21")


Bases <- df |>
  filter(Action == "Start") |>
  separate_wider_delim(cols = Value, delim = ", ", names = c("X", "Y")) |>
  select(Robot, X, Y)

Cleaned <- df |>
  left_join(Bases, join_by("Robot")) |>
  filter_out(Action == "Start")

Position <- function(Tabela) {
  Base_X <- min(Tabela$X) |> as.numeric()
  Base_Y <- min(Tabela$Y) |> as.numeric()
  Komendy <- Tabela$Action
  Wartosci <- as.numeric(Tabela$Value)

  Runs <- 0

  while (Runs < length(Komendy)) {
    Komenda <- Komendy[Runs + 1]
    Value <- Wartosci[Runs + 1]

    switch(
      Komenda,
      "MoveRight" = {
        Base_X <- Base_X + Value
      },
      "MoveLeft" = {
        Base_X <- Base_X - Value
      },
      "MoveUp" = {
        Base_Y <- Base_Y + Value
      },
      "MoveDown" = {
        Base_Y <- Base_Y - Value
      }
    )

    Runs <- Runs + 1
  }

  return(tibble(X = Base_X, Y = Base_Y))
}

map_dfr(Robots_Split, Position)


Cleaned
