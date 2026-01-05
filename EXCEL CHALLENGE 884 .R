#https://onedrive.live.com/personal/e11b26eeaacb7947/_layouts/15/Doc.aspx?sourcedoc=%7Bf04421f7-110d-40a3-bb55-a16ec3edee0f%7D&action=default&redeem=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0lRRDNJVVR3RFJHalFMdFZvVzdEN2U0UEFiM2JTeWFiWl9WZWFCOGNEdUtRS0pZP2U9d0RwWGJE&slrid=1926eaa1-7052-0000-2c09-ee3f2ec550d6&originalPath=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0lRRDNJVVR3RFJHalFMdFZvVzdEN2U0UEFiM2JTeWFiWl9WZWFCOGNEdUtRS0pZP3J0aW1lPVE1bl9BNmRNM2tn&CID=99fdc1ee-4855-462f-8ac8-edf30d7f3668&_SRM=0:G:46
library(tidyverse)

# Ex. 332111 => Two blocks are 33 and 111. Scores are 10^(2-2) = 1 & 10^(3-2) = 10.
# 111 is the lowest end, hence score needs to be doubled to 20.
# Hence total score is 1+20 = 21

df <- data.frame(
  TextNumbers = c(
    "43333",
    "2223",
    "777777777",
    "3888882277777731",
    "2111111747111117777700",
    "9999997777774444488872222",
    "1100",
    "111000",
    "55",
    "555",
    "5555",
    "123",
    "1122",
    "111222",
    "11112222",
    "2211",
    "222111",
    "988877",
    "11233",
    "77077",
    "55551",
    "15555",
    "111000111",
    "44445555",
    "1122112211",
    "8888",
    "111111111",
    "22222",
    "12121212",
    "11122",
    "990099",
    "888777",
    "55443322",
    "111123",
    "321111",
    "7770001",
    "1777000",
    "888880",
    "088888",
    "111111",
    "2233445566",
    "1222233",
    "44400",
    "998877",
    "12111121",
    "11101110111",
    "550055",
    "111222111",
    "222333",
    "1000000000"
  ),
  Score = c(
    200,
    10,
    20000000,
    11001,
    12002,
    21210,
    3,
    30,
    2,
    20,
    200,
    0,
    3,
    30,
    300,
    3,
    30,
    12,
    3,
    3,
    100,
    200,
    40,
    300,
    6,
    200,
    20000000,
    2000,
    0,
    12,
    4,
    30,
    5,
    100,
    200,
    20,
    30,
    1000,
    2000,
    20000,
    6,
    102,
    12,
    4,
    100,
    40,
    4,
    40,
    30,
    20000000
  ),
  stringsAsFactors = FALSE
)

options(scipen = 999)

Calculate_Points <- function(x) {
  data.frame(ID = str_split_1(x, "")) |>
    mutate(Group = consecutive_id(ID)) |>
    summarise(ID = paste(ID, collapse = ""), .by = Group) |>
    mutate(Groups_N = n()) |>
    filter(nchar(ID) > 1) |>
    mutate(
      k = nchar(ID),
      Group_Index = row_number(),
      Points = case_when(
        Group == Groups_N ~ (10^(k - 2)) * 2,
        .default = 10^(k - 2)
      )
    ) |>
    summarise(Points = sum(Points)) |>
    pull(Points)
}

Answer <- df |>
  mutate(
    MyAnswer = map_dbl(TextNumbers, Calculate_Points)
  )

Answer |> head()
#Compare result to expected
all.equal(df$Score, Answer$MyAnswer, check.attributes = FALSE)
