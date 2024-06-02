-- Link to challange
-- POWER QUERY CHALLENGE 188
-- https://www.linkedin.com/posts/excelbi_challenge-powerquerychallenge-daxchallenge-activity-7202881638760955904-dSDC?utm_source=share&utm_medium=member_desktop


WITH F AS (
    SELECT
        ROW_NUMBER() OVER() AS Idx,
        Store,
        "From Date" AS Beginning
    FROM
        SalesQuarters
),

T AS (
    SELECT
        ROW_NUMBER() OVER() AS Idx,
        "To Date" AS LastDate
    FROM
        SalesQuarters
),

CalendarBase AS (
    SELECT
        Store,
        generate_series(Beginning, LastDate, '1 day'::interval) AS Days
    FROM
        F
    LEFT JOIN
        T ON F.Idx = T.Idx
),

Calendar AS (
    SELECT
        Row_Number() OVER() AS IDX,
        Store,
        Days,
        date_part('quarter', Days) AS Q,
        date_part('year', Days) AS Y,
        'Q' || (date_part('quarter', Days))::character || '-' || (date_part('year', Days))::character(4) AS Quarter,
        Count(Days) OVER (Partition by Store)::INT AS DaysStore
    FROM
        CalendarBase
)

SELECT
    DISTINCT
    Calendar.Store,
    Quarter,
    Amount * ROUND(((Count(Days) OVER(Partition by Calendar.Store, Quarter))::NUMERIC) / (DaysStore::NUMERIC), 3) As Share,
    Y,
    Q
FROM
    Calendar
LEFT JOIN
    (SELECT Store, Amount FROM SalesQuarters) AS SQ ON SQ.Store = Calendar.Store
Order By
    Store,
    Y,
    Q;
