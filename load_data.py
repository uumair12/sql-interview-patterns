import duckdb
import glob
import os

con = duckdb.connect('interview.duckdb')

for path in sorted(glob.glob('data/*.csv')):
    table = os.path.splitext(os.path.basename(path))[0]
    con.execute(f"CREATE OR REPLACE TABLE {table} AS SELECT * FROM read_csv_auto('{path}')")
    count = con.execute(f"SELECT COUNT(*) FROM {table}").fetchone()[0]
    cols = con.execute(f"DESCRIBE {table}").fetchall()
    print(f"\n=== {table} ({count} rows) ===")
    print("Columns:", [(c[0], c[1]) for c in cols])
    print("Sample:", con.execute(f"SELECT * FROM {table} LIMIT 2").fetchall())

con.close()
