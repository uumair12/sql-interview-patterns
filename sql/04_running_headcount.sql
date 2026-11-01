-- Interview question: "Cumulative / running total over time."
-- No termination data exists, so headcount = cumulative hires. 

WITH monthly AS (
    SELECT DATE_TRUNC('month', hire_date) AS hire_month, COUNT(*) AS hired
    FROM employees
    GROUP BY 1
)

SELECT 
    hire_month, 
    hired,
    SUM(hired) OVER (ORDER BY hire_month) AS running_headcount
FROM monthly
ORDER BY hire_month
LIMIT 24