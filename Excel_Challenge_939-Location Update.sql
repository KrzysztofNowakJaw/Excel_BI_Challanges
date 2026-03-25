WITH Indexed AS (
    SELECT 
        ROW_NUMBER() OVER () AS "Id",
        *
    FROM public."Excel_Challenge_939-Location Update" 
    ORDER BY "Name", "Date" 
)
SELECT 
    "Name",
    LAST_VALUE("Location") OVER (PARTITION BY "Name") AS "Location",
    "Date"
FROM Indexed
ORDER BY "Id"