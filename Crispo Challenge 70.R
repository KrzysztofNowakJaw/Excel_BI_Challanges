#https://crispomwangi-my.sharepoint.com/:x:/g/personal/crispo_crispexcel_com/EVhD4MSZYphEqVSDdV0c6aYBJvBQCJgp2sQ-zMuELW2pew?rtime=LPb9X3YJ3kg
library(tidyverse)

df <- read_xlsx(File_name, range = "B2:C12")


df %>%
  group_by(id = cumsum(str_detect(Item, "Group"))) %>%
  summarise(Answer = sum(Prices))
