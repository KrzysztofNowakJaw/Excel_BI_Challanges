--https://docs.google.com/spreadsheets/d/1l6Heq7oQzneRfqXXCUqwIShySJE7YKmq/edit?gid=1197807381#gid=1197807381

WITH MarkHighest AS
  (SELECT sale_date,
          sales_value,
          sales_value = MAX(sales_value) OVER (
                                               ORDER BY sale_date, sales_value ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS SEARCH
   FROM sales_challange)
SELECT *
FROM MarkHighest
WHERE SEARCH = TRUE
