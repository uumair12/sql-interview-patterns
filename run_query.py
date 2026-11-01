import duckdb
import sys

con = duckdb.connect('interview.duckdb')

with open(sys.argv[1], 'r') as f:
    query = f.read()

cur = con.execute(query)
if cur.description:
    print([d[0] for d in cur.description])
    for row in cur.fetchall():
        print(row)

con.close()
