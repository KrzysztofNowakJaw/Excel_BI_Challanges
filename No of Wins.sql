--https://onedrive.live.com/:x:/g/personal/E11B26EEAACB7947/s!Akd5y6ruJhvhvhMAT-sLudH60krD?resid=E11B26EEAACB7947!7955&ithint=file%2Cxlsx&e=xo4RGZ&migratedtospo=true&redeem=aHR0cHM6Ly8xZHJ2Lm1zL3gvcyFBa2Q1eTZydUpodmh2aE1BVC1zTHVkSDYwa3JEP2U9eG80Ukda

SELECT 
"Champion"
,"Times Won"
,"Years of Winning"

FROM (

SELECT 
       "Champion"
	   ,COUNT("Year") AS "Times Won"
	   ,string_agg("Year"::Character(4),',') AS "Years of Winning"
	   ,DENSE_RANK() OVER (Order By COUNT("Year") DESC) AS "R"
	FROM public."No of Wins"
	GROUP BY "Champion"
	Order By COUNT("Year") DESC

)
WHERE "R" < 5