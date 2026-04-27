--https://onedrive.live.com/:x:/g/personal/E11B26EEAACB7947/s!Akd5y6ruJhvhvhj9vTemsuNBJbcx?resid=E11B26EEAACB7947!7960&ithint=file%2Cxlsx&e=aBJFNK&migratedtospo=true&redeem=aHR0cHM6Ly8xZHJ2Lm1zL3gvcyFBa2Q1eTZydUpodmh2aGo5dlRlbXN1TkJKYmN4P2U9YUJKRk5L

SELECT 
"Runners-up"
,"Count"

FROM(

SELECT 
S."Runners-up"
,COUNT(S."Runners-up") as "Count"
,DENSE_RANK() OVER (Order by COUNT(S."Runners-up") DESC) AS "R"
FROM public."Runners Up but Never Won Top 2"  AS S
WHERE
 NOT EXISTS  (
SELECT DISTINCT 
S2."Winners"
FROM public."Runners Up but Never Won Top 2" AS S2
WHERE S."Runners-up" = S2."Winners"
)
Group BY S."Runners-up")

WHERE "R" < 3