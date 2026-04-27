--https://onedrive.live.com/:x:/g/personal/E11B26EEAACB7947/s!Akd5y6ruJhvhvlGkWuundBuqyF9v?resid=E11B26EEAACB7947!8017&ithint=file%2Cxlsx&e=VJWa7m&migratedtospo=true&redeem=aHR0cHM6Ly8xZHJ2Lm1zL3gvcyFBa2Q1eTZydUpodmh2bEdrV3V1bmRCdXF5Rjl2P2U9VkpXYTdt

WITH Years AS (
SELECT 
"Region", 
"Year", 
SUM("Sales") AS "Sales"
FROM public."Highest Growth"
Group by 
"Region", 
"Year")

SELECT 
S1."Region"
,S1."Year"
FROM Years AS S1
LEFT JOIN Years AS S2 ON S1."Region" = S2."Region" AND S1."Year" = S2."Year" + 1
Order by 
COALESCE((S1."Sales" - S2."Sales") / S2."Sales"::DECIMAL(10,2),0) DESC
LIMIT 1


-- Option 2

SELECT 
S1."Region"
,S1."Year"
FROM Years AS S1

Order by COALESCE(
(S1."Sales" - LAG(S1."Sales") OVER (Partition by S1."Region" Order By "Year")) / 
LAG(S1."Sales") OVER (Partition by S1."Region" Order By "Year"),0)::NUMERIC(10,2) DESC
LIMIT 1


