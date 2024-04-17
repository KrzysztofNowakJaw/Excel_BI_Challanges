#Link to challange:
#https://www.linkedin.com/posts/omid-motamedisedeh-74aba166_excelchallenge-powerquerychllenge-excel-activity-7186106089749319681-I5Ts?utm_source=share&utm_medium=member_desktop

# Library Loading
pacman::p_load(tidyverse, gt, readxl, scales,zoo)

filename <- "CH-038 Duration Since Last Visit.xlsx"

df <- read_xlsx(filename, range = "B2:C26") |>
  janitor::clean_names()


Cleaned <- df |>
  mutate(EOM = ceiling_date(date,unit= 'month') - 1,
         Month = month(date),
         across(c('date','EOM'), \(x) as.Date(x)),
         agent_id = as.numeric(str_extract(agent_id,"\\d"))) |>
  group_by(Month) 

Answer <- Cleaned |>
  complete(agent_id = seq(from = 1, to = max(Cleaned$agent_id),by = 1)) |>
  fill(EOM,.direction = "updown") |>
  arrange(EOM) |>
  group_by(agent_id) |>
  mutate(date = na.locf.default(date),
         LastVisitInterval = EOM - date) |>
 ungroup() |>
  slice_max(order_by = date,n = 1,by = c(agent_id,Month)) |>
  summarise(AVG = mean(LastVisitInterval),.by = Month) |>
  filter(AVG > 0)

Answer


