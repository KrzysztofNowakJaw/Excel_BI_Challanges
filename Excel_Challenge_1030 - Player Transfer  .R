#https://onedrive.live.com/:x:/g/personal/e11b26eeaacb7947/IQCXw6zFatAdRbaA4Tf6jOaxAVZvr-G3liFCiN4-1s-axcs?rtime=FYy6f2_s3kg&redeem=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0lRQ1h3NnpGYXRBZFJiYUE0VGY2ak9heEFWWnZyLUczbGlGQ2lONC0xcy1heGNzP2U9VWJWTzZJ

transfers <- data.frame(
  From_Club = c("A", "B", "C", "A", "E", "D", "C", "B", "E", "A"),
  To_Club = c("B", "C", "D", "D", "A", "B", "E", "A", "D", "C"),
  Amount_M = c(50, 70, 90, 40, 60, 30, 45, 55, 25, 35)
)

library(tidyverse)


bind_cols(
  transfers |>
    summarise(Earned = sum(Amount_M), .by = From_Club) |>
    arrange(From_Club) |>
    rename(Club = From_Club),

  transfers |>
    summarise(Spent = sum(Amount_M), .by = To_Club) |>
    arrange(To_Club) |>
    select(-To_Club)
) |>
  mutate(`Net Profit` = Earned - Spent) |>
  view()
