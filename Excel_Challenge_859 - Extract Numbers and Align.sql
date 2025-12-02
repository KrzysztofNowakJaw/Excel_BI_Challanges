WITH Cleaned AS (
    SELECT 
        data1,
        UNNEST(STRING_TO_ARRAY(data2, ','))::NUMERIC AS unnest
    FROM Arrays
    WHERE LENGTH(data2) > 0
)
SELECT 
    data1 || unnest AS answer
FROM Cleaned
ORDER BY 
    ROW_NUMBER() OVER (PARTITION BY data1),
    data1,
    unnest;
