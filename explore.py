import duckdb

con = duckdb.connect('interview.duckdb')

def show(label, sql):
    print(f"\n--- {label} ---")
    for row in con.execute(sql).fetchall():
        print(row)

show("All titles", "SELECT * FROM titles ORDER BY title_id")
show("All departments", "SELECT * FROM departments ORDER BY dept_no")
show("All dept_manager rows", "SELECT * FROM dept_manager ORDER BY dept_no")
show("Hire date range", "SELECT MIN(hire_date), MAX(hire_date) FROM employees")
show("Employees in more than 1 dept", "SELECT COUNT(*) FROM (SELECT emp_no FROM dept_emp GROUP BY emp_no HAVING COUNT(*) > 1)")
show("Duplicate emp_no in employees", "SELECT COUNT(*) - COUNT(DISTINCT emp_no) FROM employees")
show("Duplicate emp_no in salaries", "SELECT COUNT(*) - COUNT(DISTINCT emp_no) FROM salaries")
show("Employees with no salary", "SELECT COUNT(*) FROM employees e LEFT JOIN salaries s ON e.emp_no = s.emp_no WHERE s.emp_no IS NULL")
show("Employees with no dept", "SELECT COUNT(*) FROM employees e LEFT JOIN dept_emp d ON e.emp_no = d.emp_no WHERE d.emp_no IS NULL")
show("Salary min/max/avg", "SELECT MIN(salary), MAX(salary), ROUND(AVG(salary)) FROM salaries")

con.close()
