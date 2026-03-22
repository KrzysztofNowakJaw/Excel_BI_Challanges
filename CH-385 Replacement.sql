#https://docs.google.com/spreadsheets/d/1vbR0Qld_u2rf86okJo06LtxBkBDvQZ3L/edit?gid=1265001925#gid=1265001925

SELECT 
"Date", 
"Product ID", 
"Total Sales",
CASE WHEN "Date" >= '2024-08-14'::DATE then overlay("Customer ID" placing 'C' from 1 for 1) 
else "Customer ID" end AS "Customer ID"

FROM public."CH-385 Replacement";