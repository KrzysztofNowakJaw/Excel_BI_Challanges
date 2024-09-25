--Link to challage
--https://www.linkedin.com/posts/omid-motamedisedeh-74aba166_powerabrquery-excel-powerabrqueryabrtips-activity-7244450548014350336-vHCD?utm_source=share&utm_medium=member_desktop
WITH Cumulative AS (
  
  SELECT 
    CT.Date, 
    CT.Customer, 
    CT.Sales, 
    BT.Balance, 
    SUM(CT.Sales) OVER (
      PARTITION BY CT.Customer 
      ORDER BY 
        CT.Date DESC
    ) AS CS, 
    -- Cumulative sum of sales
    ROW_NUMBER() OVER (
      PARTITION BY CT.Customer 
      ORDER BY 
        CT.Date DESC
    ) AS RN -- Row number for each customer, descending date
  FROM 
    CustomerTable AS CT 
    LEFT JOIN BalanceTable AS BT ON CT.Customer = BT.Customer
), 
Scope AS (
  SELECT 
    RN, 
    customer, 
    sales, 
    CS, 
    date, 
    balance, 
    cs - balance AS Difference, 
    CASE WHEN (cs - balance) > 0 then 'Positive' else 'Negative' end as Class, 
    Row_Number () OVER (
      Partition by Customer, 
      CASE WHEN (cs - balance) > 0 then 'Positive' else 'Negative' end
    ) AS IND, 
    '2024-08-31' :: DATE - Date AS Interval 
  FROM 
    Cumulative
), 
WeithtCalc AS (
  SELECT 
    Customer, 
    CS, 
    (
      CASE WHEN Class = 'Positive' then Balance - lag(CS) OVER(Partition by Customer) else Sales end
    ) AS Sales, 
    Balance, 
    Interval 
  FROM 
    Scope 
  WHERE 
    Class = 'Negative' 
    or IND = 1
) 
SELECT 
  DISTINCT customer, 
  ROUND(
    (
      SUM(Sales * Interval) OVER (Partition by Customer) / Balance
    ), 
    2
  ) AS Answer 
FROM 
  WeithtCalc
