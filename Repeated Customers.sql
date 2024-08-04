--Link to challange
--https://www.linkedin.com/posts/crispo-mwangi-6ab49453_excelchallenge-crispexcel-challenge-activity-7225712063354945539-pYxt?utm_source=share&utm_medium=member_desktop

WITH Indexed AS (
    SELECT 
        row_number() OVER() AS IDs,
        regexp_split_to_table(customers, '; ') AS Splited,
        date
    FROM CustomersChallange
),

Ranked AS (
    SELECT 
        ids,
        splited,
        date,
        row_number() OVER(PARTITION BY ids, Splited) AS Pos
    FROM Indexed
    ORDER BY date, splited DESC
)

SELECT 
    date,
    string_agg(splited, ',') AS "Repeat Customers"
FROM Ranked
WHERE Pos > 1
GROUP BY date;
