#https://crispomwangi-my.sharepoint.com/:x:/g/personal/crispo_crispexcel_com/IQDQybevRx9vTbzCNMkEgeQAAfFsb9Y2sGynS2-VXpgzd64?rtime=CXPRtG_s3kg

library(tidyverse)


Kombinacje <- lapply(1:length(faktury$Amount), function(x) {
  combn(faktury$Amount, x)
})


Solution <- map(Kombinacje, t) |>
  map(as_tibble) |>
  map(function(tab) {
    n_cols <- tab |> select(starts_with("V")) |> ncol()

    tab |>
      rowwise() |>
      mutate(Sum = sum(c_across(starts_with("V")))) |>
      ungroup() |>
      filter(Sum %in% Payment$Amount) |>
      mutate(CombinationN = n_cols, .before = 1) |>
      select(CombinationN, Sum, contains("V")) |>
      pivot_longer(cols = contains("V")) |>
      mutate(Group = n_cols) |>
      left_join(Payment, join_by(Sum == Amount)) |>
      left_join(Invoices, join_by(value == Amount)) |>
      mutate(Split = consecutive_id(Sum)) |>
      summarise(
        Answer = paste(Invoice, collapse = ","),
        .by = c(Payment, Split)
      )
  }) |>
  list_rbind() |>
  arrange(Payment) |>
  select(-Split)
