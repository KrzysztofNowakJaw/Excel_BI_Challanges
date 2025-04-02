library(fs)
library(tidyverse)

File_To_Move <- fs::dir_info(path = '/Users/krzysztofnowak/Downloads') |> 
  arrange(desc(modification_time)) |>
  filter(str_detect(path,'^.+\\.xlsx')) |>
  head(1) |>
  select(path)



fs::file_move(File_To_Move[[1]],getwd())


