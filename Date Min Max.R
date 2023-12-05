#Link to challange
#https://www.linkedin.com/feed/update/urn:li:activity:7137651807329173504/

#libraries

library(tidyverse)
library(readxl)

#load data

df <- read_xlsx("Date Min Max.xlsx",range = "A1:A20")


Answer <- df |>
  #Date operations. Extracting components and conditional columns
  mutate(
    Date = as.Date(Date),
    Year = year(Date),
    Half = ifelse(month(Date) <= 6,"1H","2H")) |>
  #Get smaller and biggest date in groups
  summarise(MinDate = min(Date),
            MaxDate = max(Date)
            ,.by = c("Year","Half")) |>
  #apply new dae format for every date column
  mutate(across(where(is.Date),\(x) format(x,"%d-%b-%Y"))) |>
  #Sort values
  arrange(Year,Half)

 df %>%
  mutate(Year = year(Date),
         Half = str_c(semester(Date),"H")) %>%
  group_by(Year, Half) %>%
  summarise(`Min Date` = min(Date),
            `Max Date` = max(Date)) %>%
  ungroup()

 
 # WITH Date_Parts AS (
 #   
 #   SELECT
 #   data
 #   ,date_part('year',data) AS Year_c
 #   ,case when date_part('month',data) <= 6 then '1H' else '2H' end AS Half
 #   
 #   FROM DatesTask ) 
 # 
 # SELECT
 # 
 # Year_c,
 # Half,
 # TO_CHAR(min(data),'DD-Mon-YYYY') AS MinDate
 # ,TO_CHAR(max(data),'DD-Mon-YYYY') AS MaxDate
 # 
 # FROM Date_Parts
 # 
 # group by 1,2
 # 
 # Order by 1,2