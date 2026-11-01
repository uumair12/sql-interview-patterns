-- Interview question: "Find consecutive streaks (islands) and breaks (gaps)."
-- Classic trick: subtract ROW_NUMBER() from the date. Consecutive days produce. 
-- the same result, so that value identifies one island. 
-- Here: streaks of consecutive calendar days on which at least one hire happened.

WITH hire_days AS (
    SELECT DISTINCT hire_date FROM employees
), 
numbered AS (
    SELECT hire_date, ROW_NUMBER() OVER (ORDER BY hire_date) AS rn
    FROM hire_days
),
grouped AS (
    SELECT hire_date, hire_date - CAST(rn AS INTEGER) AS island_id
    FROM numbered
)

SELECT
    MIN(hire_date) AS streak_start,
    MAX(hire_date) AS streak_end,
    COUNT(*) AS consecutive_hiring_days
FROM grouped
GROUP BY island_id
ORDER BY consecutive_hiring_days DESC, streak_start
LIMIT 10;