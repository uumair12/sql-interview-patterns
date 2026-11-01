-- Interview question: "Employees who earn more than their manager."
-- A department can have several managers in this data, so we compare against
-- the highest paid manager (i.e. earning more than All managers of the department).

WITH dept_top_manager_salary AS (
    SELECT dm.dept_no, MAX(s.salary) AS top_manager_salary
    FROM dept_manager dm
    JOIN salaries s ON dm.emp_no = s.emp_no
    GROUP BY dm.dept_no
)

SELECT
    d.dept_name,
    t.top_manager_salary, 
    COUNT(*) AS employees_earning_more
FROM dept_emp de
JOIN salaries s ON de.emp_no = s.emp_no
JOIN dept_top_manager_salary t ON de.dept_no = t.dept_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE s.salary > t.top_manager_salary
  AND de.emp_no NOT IN (SELECT emp_no FROM dept_manager)
GROUP BY d.dept_name, t.top_manager_salary
ORDER BY employees_earning_more DESC;