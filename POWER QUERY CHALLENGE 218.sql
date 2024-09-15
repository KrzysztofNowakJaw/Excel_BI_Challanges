-- Link to challange
--https://www.linkedin.com/posts/excelbi_challenge-powerquerychallenge-daxchallenge-activity-7240937984114491393-UPyv?utm_source=share&utm_medium=member_desktop
WITH Labels AS (
    SELECT 
        project,
        task,
        CASE 
            WHEN completiondate IS NULL THEN 'Incomplete' 
            ELSE 'Complete'  
        END AS Label
    FROM CompletedTask
),

IC AS (
    SELECT
        project,
        STRING_AGG(task, ',') AS Incomplete_tasks
    FROM Labels		
    WHERE Label = 'Incomplete'
    GROUP BY project
),

CO AS (
    SELECT
        project,
        STRING_AGG(task, ',') AS complete_tasks
    FROM Labels		
    WHERE Label = 'Complete'
    GROUP BY project
)

SELECT 
    DISTINCT Labels.project,
    CO.complete_tasks,
    IC.Incomplete_tasks
FROM Labels
LEFT JOIN CO ON CO.project = Labels.project
LEFT JOIN IC ON IC.project = Labels.project
ORDER BY project;
