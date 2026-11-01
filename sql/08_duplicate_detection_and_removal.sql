-- Interview question: "Find and remove duplicate rows, keeping one."
-- The real data has no duplicates, so we build a practice copy with duplicates
-- deliberately injected, then clean it. The original salaries table is untouched.

-- 1) Practice table: all salaries + a second copy of the first ~100 employees
CREATE OR REPLACE TABLE salaries_dup AS
SELECT * FROM salaries
UNION ALL
SELECT * FROM salaries WHERE emp_no <= 10100;

-- 2) Delete duplicates, keeping the first physical row per (emp_no, salary)
DELETE FROM salaries_dup
WHERE rowid IN (
    SELECT rowid
    FROM (
        SELECT
            rowid,
            ROW_NUMBER() OVER (PARTITION BY emp_no, salary ORDER BY rowid) AS rn
        FROM salaries_dup
    )
    WHERE rn > 1
);

-- 3) Verify: cleaned table should match the original exactly
SELECT
    (SELECT COUNT(*) FROM salaries) AS original_rows,
    (SELECT COUNT(*) FROM salaries_dup) AS rows_after_cleanup,
    (SELECT COUNT(*) - COUNT(DISTINCT emp_no) FROM salaries_dup) AS duplicates_remaining