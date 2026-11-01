# SQL Interview Patterns (DuckDB)

Nine of the most commonly asked SQL interview questions, solved on a real
300,024-employee HR dataset. Each query lives in its own file with a comment
explaining the question and the technique.

## Dataset

"Human Resources Data Set Sample" (Kaggle, uploaded by tarkhon), a CSV version of
the classic employees sample database: employees, departments, dept_emp,
dept_manager, salaries and titles.

Dataset notes that shaped the queries:
- One salary per employee, no salary history and no termination dates
  (so "headcount" means cumulative hires).
- No employee-to-manager links, only department-to-manager.
- About 31,500 employees belong to more than one department.

## Queries and techniques

| # | Interview question | Technique | File |
|---|---|---|---|
| 1 | Nth highest salary | `DENSE_RANK()`, which handles ties (unlike `LIMIT/OFFSET`) | `01_nth_highest_salary.sql` |
| 2 | Top 3 earners per department | `ROW_NUMBER()` + `PARTITION BY` | `02_top3_per_department.sql` |
| 3 | Earn more than their manager | CTE + joins + `NOT IN` | `03_earn_more_than_manager.sql` |
| 4 | Running headcount over time | `SUM() OVER (ORDER BY ...)` | `04_running_headcount.sql` |
| 5 | Consecutive streaks (gaps and islands) | Date minus `ROW_NUMBER()` trick | `05_gaps_and_islands.sql` |
| 6 | Month calendar with zero-activity months | Recursive CTE + `LEFT JOIN` | `06_recursive_month_calendar.sql` |
| 7 | Walk a hierarchy | Recursive CTE | `07_recursive_title_ladder.sql` |
| 8 | Find and delete duplicates | `ROW_NUMBER()` + `DELETE` | `08_duplicate_detection_and_removal.sql` |
| 9 | Rows to columns (pivot) | `SUM(CASE WHEN ...)` | `09_pivot_headcount_by_department.sql` |

## Sample results

**Top 3 earners per department (excerpt)**

| Department | Rank | Salary |
|---|---|---|
| Development | 1 | 110,449 |
| Development | 2 | 106,109 |
| Development | 3 | 105,086 |

**Highest salaries:** 129,492, then 127,238, then 127,041.

**Gaps and islands:** one continuous hiring streak of 5,264 days
(1985-02-01 to 1999-07-01); gaps only appear in 1999.

Full output for every query is in `results.txt`.

## Honest notes and assumptions

- **Query 3:** departments have several managers, so I compare against the
  highest-paid manager. Many employees out-earn managers because manager
  salaries in this dataset are low.
- **Query 7:** the data has no org chart, so the job-title ladder
  (Assistant Engineer, Engineer, Senior Engineer, Technique Leader) is defined
  inside the query as an assumption. It joins real employee and salary data.
- **Query 8:** the data contains no duplicates, so the query builds a practice
  copy (`salaries_dup`) with duplicates injected, then cleans it. The original
  table is untouched.
- **Query 9:** employees in multiple departments are counted once per department.

## How to run

```bash
pip install duckdb
# download the CSVs into a data/ folder (see Dataset), then:
python load_data.py
python run_all.py      # runs every query and writes results.txt
```

## Learning Outcomes

Window functions for ranking and running totals, the gaps-and-islands pattern,
recursive CTEs, deduplication with `ROW_NUMBER()`, and pivoting with conditional
aggregation, plus checking a dataset's real shape before writing queries.
