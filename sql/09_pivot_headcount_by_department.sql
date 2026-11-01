-- Interview question: "Turn rows into columns (pivot) using CASE WHEN."
-- Employees in several departments are counted once per department.

SELECT
    EXTRACT(year FROM e.hire_date) AS hire_year,
    SUM(CASE WHEN de.dept_no = 'd001' THEN 1 ELSE 0 END) AS marketing, 
    SUM(CASE WHEN de.dept_no = 'd002' THEN 1 ELSE 0 END) AS finance,
    SUM(CASE WHEN de.dept_no = 'd003' THEN 1 ELSE 0 END) AS human_resources,
    SUM(CASE WHEN de.dept_no = 'd004' THEN 1 ELSE 0 END) AS production,
    SUM(CASE WHEN de.dept_no = 'd005' THEN 1 ELSE 0 END) AS development,
    SUM(CASE WHEN de.dept_no = 'd006' THEN 1 ELSE 0 END) AS quality_management,
    SUM(CASE WHEN de.dept_no = 'd007' THEN 1 ELSE 0 END) AS sales,
    SUM(CASE WHEN de.dept_no = 'd008' THEN 1 ELSE 0 END) AS research,
    SUM(CASE WHEN de.dept_no = 'd009' THEN 1 ELSE 0 END) AS customer_service
FROM employees e
JOIN dept_emp de ON E.emp_no = de.emp_no
GROUP BY 1 
ORDER BY 1