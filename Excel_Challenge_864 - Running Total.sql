WITH Cleaned AS (
    SELECT 
        to_char("Date", 'MM')   AS Ids,
        to_char("Date", 'Mon')  AS Months,
        SUM(
            CASE 
                WHEN EXTRACT(DOW FROM "Date") BETWEEN 1 AND 5 
                THEN "Amount" 
                ELSE 0 
            END
        ) AS Amount
    FROM public."EXCEL_CHALLENGE_864"
    GROUP BY 
        to_char("Date", 'MM'),
        to_char("Date", 'Mon')
)

SELECT 
    Months,
    SUM(Amount) OVER (ORDER BY Ids) AS Running_Total
FROM Cleaned
ORDER BY Ids;
