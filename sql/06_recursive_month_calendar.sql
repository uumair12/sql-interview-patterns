-- Interview question: "Show every month, including months with zero activity."
-- A recursive CTE generates the calendar; LEFT JOIN keeps empty months.

WITH RECURSIVE months AS (
    SELECT DATE '1985-01-01' AS month_start
    UNION ALL
    SELECT CAST(month_start + INTERVAL 1 MONTH AS DATE)
    FROM months
    WHERE month_start < DATE '2000-01-01'
)

SELECT
    m.month_start,
    COUNT(e.emp_no) AS hires
FROM months m
LEFT JOIN employees e
    ON CAST(DATE_TRUNC('month', e.hire_date) AS DATE) = m.month_start
GROUP BY m.month_start
ORDER BY m.month_start
LIMIT 24;