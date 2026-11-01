-- Interview question: "Walk a hierarchy with a recursive CTE."
-- The dataset has NO employee-to-manager links, so we do not fake an org chart.
-- Instead we define the career ladder between job titles ourselves (an assumption,
-- stated in the README) and walk it recursively, joining real employee/salary data.
WITH RECURSIVE ladder_edges(from_title, to_title) AS (
    VALUES
        ('e0001', 'e0002'),   -- Assistant Engineer -> Engineer
        ('e0002', 'e0003'),   -- Engineer -> Senior Engineer
        ('e0003', 'e0004'),   -- Senior Engineer -> Technique Leader
        ('s0001', 's0002')    -- Staff -> Senior Staff
),
career_path AS (
    SELECT 'e0001' AS title_id, 1 AS step
    UNION ALL
    SELECT l.to_title, c.step + 1
    FROM career_path c
    JOIN ladder_edges l ON l.from_title = c.title_id
)
SELECT
    c.step,
    t.title,
    COUNT(e.emp_no) AS employees,
    ROUND(AVG(s.salary)) AS avg_salary
FROM career_path c
JOIN titles t ON t.title_id = c.title_id
LEFT JOIN employees e ON e.emp_title_id = c.title_id
LEFT JOIN salaries s ON s.emp_no = e.emp_no
GROUP BY c.step, t.title
ORDER BY c.step