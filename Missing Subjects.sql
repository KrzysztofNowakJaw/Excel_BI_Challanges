--https://onedrive.live.com/:x:/g/personal/E11B26EEAACB7947/s!Akd5y6ruJhvhvkyzNWKzcM5Hexpj?resid=E11B26EEAACB7947!8012&ithint=file%2Cxlsx&e=PwP0FN&migratedtospo=true&redeem=aHR0cHM6Ly8xZHJ2Lm1zL3gvcyFBa2Q1eTZydUpodmh2a3l6TldLemNNNUhleHBqP2U9UHdQMEZO

WITH split AS (
    SELECT
        unnest(regexp_split_to_array("Subjects", ', ')) AS "Subjects",
        "Names",
        "Gender"
    FROM public."SQL_NAME"
)

SELECT
    s1."Gender",
    string_agg(DISTINCT s1."Subjects", ',') AS "UniqueSubjects"
FROM split AS s1
WHERE
    s1."Gender" = 'Female'
    AND s1."Subjects" NOT IN (
        SELECT s2."Subjects"
        FROM split AS s2
        WHERE s2."Gender" = 'Male'
    )
GROUP BY s1."Gender"

UNION

SELECT
    s1."Gender",
    string_agg(DISTINCT s1."Subjects", ',') AS "UniqueSubjects"
FROM split AS s1
WHERE
    s1."Gender" = 'Male'
    AND s1."Subjects" NOT IN (
        SELECT s2."Subjects"
        FROM split AS s2
        WHERE s2."Gender" = 'Female'
    )
GROUP BY s1."Gender";