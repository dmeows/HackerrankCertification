WITH hours_worked AS (
    SELECT
        emp_id,
        CASE
            WHEN MINUTE(TIMESTAMP) >= MINUTE(LAG(TIMESTAMP) OVER (PARTITION BY CAST(TIMESTAMP AS DATE), emp_id ORDER BY TIMESTAMP)) 
                THEN HOUR(TIMESTAMP) - HOUR(LAG(TIMESTAMP) OVER (PARTITION BY CAST(TIMESTAMP AS DATE), emp_id ORDER BY TIMESTAMP))
            ELSE HOUR(TIMESTAMP) - HOUR(LAG(TIMESTAMP) OVER (PARTITION BY CAST(TIMESTAMP AS DATE), emp_id ORDER BY TIMESTAMP)) - 1
        END AS hours_worked
    FROM attendance
    -- only weekends
    WHERE WEEKDAY(TIMESTAMP) IN (5, 6)
)
SELECT
    emp_id,
    SUM(hours_worked) AS total_hours_worked
FROM hours_worked
GROUP BY emp_id
ORDER BY total_hours_worked DESC;
