WITH Returns AS (
    SELECT
        "Product",
        CASE
            WHEN "IsReturn" = TRUE
                THEN "Quantity" * -1
            ELSE "Quantity"
        END AS Quantity,
        "UnitPrice"
    FROM public."PQ_Challenge_355"
),
Totals AS(
SELECT
    CASE
        WHEN "Product" IS NULL THEN 'Total'
        ELSE "Product"
    END AS Region,
    SUM(Quantity) AS TotalQty,
    SUM(Quantity * "UnitPrice") AS TotalAmount,
    AVG("UnitPrice")::NUMERIC(10,2) AS AveragePrice
FROM Returns
GROUP BY ROLLUP ("Product"))

SELECT 
Region
,TotalQty
,TotalAmount
,(TotalAmount / TotalQty)::NUMERIC(10,2) AS AveragePrice

FROM Totals

Order By region


