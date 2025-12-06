#Download recent excel file to project folder

library(fs)
library(tidyverse)
library(readxl)

File_To_Move <- fs::dir_info(path = '/Users/krzysztofnowak/Downloads') |>
  arrange(desc(modification_time)) |>
  filter(str_detect(path, '^.+\\.xlsx')) |>
  head(1) |>
  select(path)


fs::file_move(File_To_Move[[1]], getwd())


File_name <- str_extract(File_To_Move, '(?<=Downloads\\/).+.xlsx$')

read_xlsx(File_name)

File_name

# Remove the file after reading
fs::file_delete(File_name)
