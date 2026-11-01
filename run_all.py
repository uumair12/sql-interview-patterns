import duckdb
import glob

con = duckdb.connect('interview.duckdb')

with open('results.txt', 'w') as out:
    for path in sorted(glob.glob('sql/*.sql')):
        with open(path, 'r') as f:
            query = f.read()
        cur = con.execute(query)
        out.write(f"\n===== {path} =====\n")
        if cur.description:
            out.write(str([d[0] for d in cur.description]) + "\n")
            for row in cur.fetchmany(15):
                out.write(str(row) + "\n")
        print("OK:", path)

con.close()
print("\nDone. Open results.txt to see the output of every query.")