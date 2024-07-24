library(tidyverse)
library(readxl)

# Define the filename of the Excel file containing the grid data
filename <- 'CH-087 Price List.xlsx'

Prices <- read_xlsx(filename,range = 'B2:D9') 
Transactions <- read_xlsx(filename,range = 'G2:I11')
Expected <- read_xlsx(filename,range = 'G2:J11')

Answer <- Transactions |>
  inner_join(Prices,join_by(Product,closest(Date>=`From Date`))) |>
  select(Date,Product,Quantity,Price)

Answer

all.equal(Answer,Expected)


# WITH Differences AS (
#   SELECT 
#   date,
#   Transactions.product AS Product,
#   price
#   ,quantity
#   ,date - from_date AS Difference
#   ,DENSE_RANK() OVER (PARTITION BY Transactions.product, date ORDER BY date - from_date) AS Ranking
#   FROM Transactions
#   INNER JOIN Prices ON Transactions.product = Prices.product AND Transactions.date >= Prices.from_date
# )
# 
# SELECT 
# date
# ,Product
# ,quantity
# ,price
# FROM Differences
# WHERE Ranking = 1
# Order By date
