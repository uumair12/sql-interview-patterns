-- Interview question: "Find the Nth highest salary."
-- DENSE_RANK() handels ties correctly; LIMIT/OFFSET does not.
-- Change salary_rank <= 5 to = N for a single Nth value. 

WITH salary_levels AS (
    SELECT
        salary, 
        COUNT(*) AS employees_at_salary,
        DENSE_RANK() OVER (ORDER BY salary DESC) AS salary_rank
    FROM salaries
    GROUP BY salary
)

SELECT salary_rank, salary, employees_at_salary
FROM salary_levels
WHERE salary_rank <= 5
ORDER BY salary_rank;