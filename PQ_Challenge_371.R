library(tidyverse)
library(readxl)
library(gt)

df <- read_xlsx(File_name, range = "A1:C21")

Answer <- df |>
  mutate(Status = str_extract(Value, '[aA-zZ]+')) |>
  fill(Status, .direction = "down") |>
  mutate(`Status Occurrence` = consecutive_id(Status)) |>
  filter_out(row_number() == 1, .by = c(Status, `Status Occurrence`)) |>
  summarise(
    `Average Reading` = mean(as.numeric(Value)),
    `Max Reading` = max(as.numeric(Value)),
    `Min Reading` = min(as.numeric(Value)),
    .by = c(`Status Occurrence`, Status)
  )


Answer |>
  gt() |>
  # ── Visual theme & tweaks ──────────────────────────────────────────────────
  opt_stylize(style = 6, color = "blue") |> # clean striped theme
  opt_row_striping() |>
  tab_options(
    table.font.size = px(13),
    column_labels.font.weight = "bold",
    row_group.font.weight = "bold",
    row_group.background.color = "#e8f0fe",
    grand_summary_row.background.color = "#dce8f5",
    table.border.top.color = "#2171b5",
    table.border.top.width = px(3)
  ) |>
  # ── Header ─────────────────────────────────────────────────────────────────
  tab_header(
    title = md("**Power Query Challenge 371**"),
    subtitle = md(
      "Generate the Average, Max and Min readings for various statuses."
    )
  ) |>
  tab_source_note("Source: https://www.linkedin.com/in/excelbi/ ")
