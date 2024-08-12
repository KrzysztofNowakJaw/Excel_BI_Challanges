--Link to challange
-- https://www.linkedin.com/posts/omid-motamedisedeh-74aba166_powerabrquery-excel-powerabrqueryabrtips-activity-7228505467411427329-qpDB?utm_source=share&utm_medium=member_desktop


WITH Sums AS (
    SELECT 
        product,
        date_part('month', date) AS Month,
        SUM(quantity) OVER (PARTITION BY date_part('month', date) ORDER BY date_part('month', date)) AS Monthly,
        SUM(quantity) OVER (PARTITION BY date_part('month', date), product) AS MonthlyProduct
    FROM 
        Sales96
),

ranks AS (
    SELECT 
        product,
        month,
        Monthly,
        MonthlyProduct,
        DENSE_RANK() OVER (PARTITION BY month ORDER BY MonthlyProduct DESC) AS SalesRank
    FROM 
        Sums
),

renamed AS (
    SELECT DISTINCT
        month,
        product,
        CASE 
            WHEN SalesRank > 2 THEN 'Other' 
            ELSE product  
        END AS ProductNew,
        MonthlyProduct::FLOAT,
        Monthly::FLOAT,
        SalesRank
    FROM 
        ranks
)

SELECT 
    month,
    productnew,
    (SUM(monthlyproduct) / monthly * 100)::INT || '%' AS Percentage
FROM 
    renamed
GROUP BY 
    month, monthly, productnew
ORDER BY 
    month,LENGTH(productnew) 
