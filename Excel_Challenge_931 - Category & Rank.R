#https://onedrive.live.com/:x:/g/personal/e11b26eeaacb7947/IQAKQH2h6uokQLEcL-UaWoiuAZUD8sff31zSkPlldnpTy9w?rtime=TeXo4emA3kg&redeem=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0lRQUtRSDJoNnVva1FMRWNMLVVhV29pdUFaVUQ4c2ZmMzF6U2tQbGxkbnBUeTl3P2U9UTE3Y1BD

library(tidyverse)
library(readxl)

df <- read_xlsx(File_name, range = "A2:C24")

Mapping <- data.frame(
  `Tenure Level` = c("Senior", "Mid-Level", "Junior"),
  From = c(6, 3, 0),
  To = c(Inf, 6, 3)
)

Intervals <- df |>
  mutate(
    `Hire Date` = as.Date(`Hire Date`, format = '%m/%d/%Y'),
    Time = (difftime(time1 = Sys.Date(), time2 = `Hire Date`, units = "days") /
      365) |>
      as.numeric()
  ) |>
  left_join(Mapping, join_by(between(Time, From, To))) |>
  mutate(Rank = dense_rank(desc(Time)), .by = Department) |>
  select(-c(From, To)) |>
  arrange(Department, Rank) |>
  select(-c(Time, `Hire Date`))

Intervals
