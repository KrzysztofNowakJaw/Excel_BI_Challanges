--https://docs.google.com/spreadsheets/d/1rXb6nhRI3ixzuXO58TRzX1lq7j8AmUFd/edit?gid=1852143531#gid=1852143531

WITH Indexed AS (
    SELECT
         *
        ,ROW_NUMBER() OVER ()  AS "RN"
        ,"Customer" || "Product" AS "Group"
    FROM public."CH-386_Index"
)

SELECT
     "Date"
    ,"Customer"
    ,"Product"
    ,"Sale"
    ,CASE 
        WHEN ROW_NUMBER() OVER (PARTITION BY "Group" ORDER BY "RN")::TEXT = '1' 
        THEN '*' 
        ELSE '' 
     END AS "Index"
FROM Indexed
ORDER BY "RN"