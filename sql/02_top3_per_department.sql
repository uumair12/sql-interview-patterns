-- Interview question: "Top N earners in each department"
-- ROW_NUMBER() with PARTITION BY; emp_no breaks ties so results are deterministic. 

WITH ranked AS (
    SELECT
        d.dept_name, 
        e.emp_no, 
        e.first_name,
        e.last_name,
        s.salary,
        ROW_NUMBER() OVER (
            PARTITION BY d.dept_no
            ORDER BY s.salary DESC, e.emp_no
        ) AS rnk
    FROM dept_emp de
    JOIN departments d ON de.dept_no = d.dept_no
    JOIN employees e ON de.emp_no = e.emp_no
    JOIN salaries s ON e.emp_no = s.emp_no
)
SELECT dept_name, rnk, emp_no, first_name, last_name, salary
FROM ranked
WHERE rnk <= 3
ORDER BY dept_name, rnk;