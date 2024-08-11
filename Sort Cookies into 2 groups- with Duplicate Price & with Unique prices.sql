WITH AllPrice AS (
    SELECT 
        price,
        COUNT(cookie_name) AS QT
    FROM PricesDup
    GROUP BY price
),

Duplicated AS (
    SELECT 
        AP.price,
        PD.cookie_name,
        ROW_NUMBER() OVER() AS IDs
    FROM AllPrice AS AP
    INNER JOIN PricesDup AS PD ON AP.price = PD.price
    WHERE QT > 1
),

Uniques AS (
    SELECT 
        AP.price,
        PD.cookie_name,
        ROW_NUMBER() OVER() AS IDs
    FROM AllPrice AS AP
    INNER JOIN PricesDup AS PD ON AP.price = PD.price
    WHERE QT = 1
)

SELECT
    Duplicated.cookie_name AS DuplicatedC,
    Uniques.cookie_name AS UniqueC
FROM Duplicated 
LEFT JOIN Uniques ON Duplicated.IDs = Uniques.IDs;
