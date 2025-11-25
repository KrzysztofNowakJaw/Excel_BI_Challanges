--https://www.linkedin.com/posts/excelbi_excel-challenge-problem-activity-7398933469122150400-IXhv?utm_source=share&utm_medium=member_desktop&rcm=ACoAACOAYFUBiUaa9Y4mEwqoxo7zB0wNDVUrSg0
     WITH Summary AS (
             SELECT Champion,
                    YEAR,
                    count(YEAR) OVER (
                    PARTITION BY Champion
                    ) AS trophs,
                    COALESCE(
                    YEAR - LAG(YEAR) OVER (
                    PARTITION BY champion
                     ORDER BY YEAR
                    ),
                    0
                    ) AS IsCons,
                    ROW_NUMBER() OVER (
                    PARTITION BY Champion
                     ORDER BY YEAR
                    ) AS Index
               FROM soccer
          ),
          InScope AS (
             SELECT Champion
               FROM Summary
              WHERE trophs > 1
                AND Index > 1
           GROUP BY Champion
             HAVING min(iscons) > 4
          )
   SELECT A.Champion,
          STRING_AGG(A.Year::TEXT, ',') AS Wins
     FROM soccer AS A
    INNER JOIN InScope AS B ON A.Champion = B.Champion
 GROUP BY A.Champion
 ORDER BY A.Champion