-- https://onedrive.live.com/:x:/g/personal/E11B26EEAACB7947/s!Akd5y6ruJhvhvlwOTTyarQcKBBsj?resid=E11B26EEAACB7947!8028&ithint=file%2Cxlsx&e=SvOpzW&migratedtospo=true&redeem=aHR0cHM6Ly8xZHJ2Lm1zL3gvcyFBa2Q1eTZydUpodmh2bHdPVFR5YXJRY0tCQnNqP2U9U3ZPcHpX

WITH breaks AS (
    SELECT
        "Breakdown Date",
        "Machine ID",
        ROW_NUMBER() OVER (
            PARTITION BY "Machine ID"
            ORDER BY "Machine ID", "Breakdown Date"
        ) AS "Occ"
    FROM public."Fourth Transaction"
)

SELECT DISTINCT
    b."Machine ID",
    b."Breakdown Date"
FROM breaks AS b
INNER JOIN (
    SELECT
        "Machine ID",
        "Breakdown Date",
        "Occ"
    FROM breaks
    GROUP BY "Machine ID", "Occ", "Breakdown Date"
    HAVING MAX("Occ") > 4
) AS b2 ON b."Machine ID" = b2."Machine ID"
WHERE b."Occ" = 4
ORDER BY b."Machine ID";