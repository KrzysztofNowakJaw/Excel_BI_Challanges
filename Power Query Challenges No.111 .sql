--Link to challange
--https://www.linkedin.com/posts/omid-motamedisedeh-74aba166_powerabrquery-excel-powerabrqueryabrtips-activity-7239377104709017600-5aV-?utm_source=share&utm_medium=member_desktop



-- Step 1: Create the table
CREATE TABLE CompareRows (
    Date DATE,
    Product CHAR(1),
    Sales INTEGER
);

-- Step 2: Insert the provided data
INSERT INTO CompareRows (Date, Product, Sales) VALUES
('2024-01-01', 'A', 1),
('2024-01-01', 'B', 1),
('2024-01-01', 'C', 3),
('2024-01-01', 'D', 6),
('2024-02-01', 'B', 3),
('2024-02-01', 'C', 6),
('2024-02-01', 'D', 5),
('2024-03-01', 'A', 6),
('2024-03-01', 'B', 1),
('2024-03-01', 'C', 1),
('2024-04-01', 'A', 3),
('2024-04-01', 'D', 4),
('2024-05-01', 'A', 5),
('2024-05-01', 'D', 2),
('2024-06-01', 'C', 6),
('2024-06-01', 'A', 2),
('2024-07-01', 'B', 4),
('2024-08-01', 'B', 6),
('2024-09-01', 'C', 3),
('2024-09-01', 'A', 4),
('2024-09-01', 'C', 5),
('2024-10-01', 'B', 4),
('2024-10-01', 'D', 3),
('2024-10-01', 'B', 1);







SELECT
    date,
    daily,
    Previous
FROM (
    SELECT
        date,
        SUM(sales) AS daily,
        LAG(SUM(sales)) OVER (PARTITION BY date_part('day', date) ORDER BY date) AS Previous
    FROM
        CompareRows
    GROUP BY
        date
) AS Sums
WHERE
    daily > Previous;
