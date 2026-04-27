-- https://onedrive.live.com/:x:/g/personal/E11B26EEAACB7947/s!Akd5y6ruJhvhvmHBp1b_vH0kx7gh?resid=E11B26EEAACB7947!8033&ithint=file%2Cxlsx&e=Wic1bX&migratedtospo=true&redeem=aHR0cHM6Ly8xZHJ2Lm1zL3gvcyFBa2Q1eTZydUpodmh2bUhCcDFiX3ZIMGt4N2doP2U9V2ljMWJY

WITH indexed AS (
    SELECT
        ROW_NUMBER() OVER ()  AS "Ind",
        "City 1",
        "City 2",
        "Agency",
        "Cost"
    FROM public."Cities Avg Cost"
),

arrays AS (
    SELECT
        "Ind",
        UNNEST(array_agg(ARRAY["City 1", "City 2"])) AS "Cities"
    FROM indexed
    GROUP BY 1
    ORDER BY 1, UNNEST(array_agg(ARRAY["City 1", "City 2"]))
)

SELECT
    "Cities",
    substring("Cities" FROM '^[a-zA-Z]+')  AS "City1",
    substring("Cities" FROM '[a-zA-Z]+$')  AS "City2",
    AVG("Cost")                             AS "AvgCost"
FROM (
    SELECT
        string_agg("Cities", ',') AS "Cities",
        "Cost"
    FROM arrays
    INNER JOIN indexed ON indexed."Ind" = arrays."Ind"
    GROUP BY arrays."Ind", "Cost"
) AS sub
GROUP BY 1;