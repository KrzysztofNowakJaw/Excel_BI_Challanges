-- https://onedrive.live.com/:x:/g/personal/E11B26EEAACB7947/s!Akd5y6ruJhvhviPVZOEX7I8V8PZ-?resid=E11B26EEAACB7947!7971&ithint=file%2Cxlsx&e=6AQ10f&migratedtospo=true&redeem=aHR0cHM6Ly8xZHJ2Lm1zL3gvcyFBa2Q1eTZydUpodmh2aVBWWk9FWDdJOFY4UFotP2U9NkFRMTBm

WITH Scope_ AS (
SELECT 
"Winners"
FROM public."Avg Span of Winning"
Group by "Winners"
HAVING COUNT("Year") > 1),

Indexed AS (
SELECT 
S."Winners",
S."Year"
,ROW_NUMBER() OVER (Partition by S."Winners" Order By S."Year") as "Ind"
FROM public."Avg Span of Winning" as S
INNER JOIN Scope_ ON S."Winners" = Scope_."Winners")

Select S1."Winners"
,AVG(S1."Year" - S2."Year")
FROM Indexed AS S1
LEFT JOIN Indexed AS S2 ON (S1."Ind" = S2."Ind" + 1) AND S1."Winners" = S2."Winners"
WHERE S2."Year" IS NOT NULL
Group By S1."Winners"
Order by S1."Winners"
