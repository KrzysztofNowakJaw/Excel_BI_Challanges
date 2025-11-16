-- https://onedrive.live.com/personal/e11b26eeaacb7947/_layouts/15/Doc.aspx?sourcedoc=%7B840f782d-ee81-4262-a26b-6a851321f085%7D&action=default&redeem=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0VTMTRENFNCN21KQ29tdHFoUk1oOElVQlJ2NnBIZkdITS0tSkU4NkdmckV4aGc_ZT1XRGE0bzc&slrid=04e5d9a1-3060-a000-b031-60d249eb0684&originalPath=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0VTMTRENFNCN21KQ29tdHFoUk1oOElVQlJ2NnBIZkdITS0tSkU4NkdmckV4aGc_cnRpbWU9RzJyWEhfZ2sza2c&CID=89096ecc-6409-4f8c-9cb9-17448cb3fa18&_SRM=0:G:41

-- CTE "Summarize": calculates total revenue per group
WITH Summarize AS (
    SELECT 
        group_id,
        SUM(revenue) AS Rev
    FROM Revenue
    GROUP BY group_id
),

-- CTE "Ranked": pairs each group with all other groups (CROSS JOIN)
-- and ranks them based on the smallest revenue difference
Ranked AS (
    SELECT
        S.group_id AS GroupID,      -- current group
        S1.group_id AS NNG,         -- candidate "nearest" group
        S1.Rev AS NNGR,             -- candidate group's revenue
        DENSE_RANK() OVER (
            PARTITION BY S.group_id
            ORDER BY ABS(S.Rev - S1.Rev)  -- rank based on smallest absolute revenue difference
        ) AS Diff_rank
    FROM Summarize AS S
    CROSS JOIN Summarize AS S1
    WHERE S.group_id <> S1.group_id      -- exclude comparison with itself
)

-- Final query: selects the nearest group(s) for each group based on revenue difference
SELECT 
    GroupID,
    STRING_AGG(NNG, ',') AS "Next Nearest Group",       -- groups with closest revenue
    MAX(NNGR) AS "Next Nearest Group Revenue"           -- their revenue
FROM Ranked
WHERE Diff_rank = 1                                     -- keep only the closest group(s)
GROUP BY GroupID;
