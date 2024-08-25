--Link to challange
-- https://www.linkedin.com/posts/crispo-mwangi-6ab49453_excelchallenge-exceltips-crispexcel-activity-7233495852944658432-B1vr?utm_source=share&utm_medium=member_desktop


WITH SplitN AS (
  SELECT 
    ROW_NUMBER() OVER () AS IDs, 
    regexp_split_to_table(name, '\s+') AS Separated, 
    regexp_count(
      regexp_split_to_table(name, '\s+'), 
      '[A-Z]'
    ) AS Lenght 
  FROM 
    ChallangeNames
) 
SELECT 
  IDs, 
  string_agg(separated, ' ') 
FROM 
  SplitN 
WHERE 
  LENGTH(separated) = Lenght 
GROUP BY 
  IDs
