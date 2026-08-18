"""Generate supabase/migrate.sql (schema + data + read policies) from src/data/seed.json.
Column names are quoted to exactly match the JSON keys the app expects, so
`.from('Table').select('*')` returns rows in the app's shape with no mapping."""
import json
import os

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

with open(os.path.join(ROOT, 'src', 'data', 'seed.json'), encoding='utf-8') as f:
    data = json.load(f)


def col_type(vals):
    seen = False
    for v in vals:
        if v is None:
            continue
        seen = True
        if isinstance(v, bool) or not isinstance(v, (int, float)):
            return 'text'
    return 'numeric' if seen else 'text'


def sql_val(v, typ):
    if v is None or v == '':
        return 'NULL'
    if typ == 'numeric':
        try:
            return str(int(v)) if isinstance(v, int) else str(float(v))
        except Exception:
            return 'NULL'
    return "'" + str(v).replace("'", "''") + "'"


out = [
    "-- Malar Finance - full migration (schema + data + read policies)",
    "-- Paste into Supabase > SQL Editor > Run. Safe to re-run (drops & recreates).",
    "",
]

for table, rows in data.items():
    keys = []
    for r in rows:
        for k in r.keys():
            if k not in keys:
                keys.append(k)
    if not keys:
        keys = ['id']
    types = {k: col_type([r.get(k) for r in rows]) for k in keys}

    out.append(f'drop table if exists "{table}" cascade;')
    cols = ", ".join(f'"{k}" {types[k]}' for k in keys)
    out.append(f'create table "{table}" ({cols});')

    if rows:
        collist = ", ".join(f'"{k}"' for k in keys)
        BATCH = 100
        for i in range(0, len(rows), BATCH):
            chunk = rows[i:i + BATCH]
            vals = ["(" + ", ".join(sql_val(r.get(k), types[k]) for k in keys) + ")" for r in chunk]
            out.append(f'insert into "{table}" ({collist}) values\n' + ",\n".join(vals) + ";")

    out.append(f'alter table "{table}" enable row level security;')
    out.append(f'create policy "read_all_{table}" on "{table}" for select using (true);')
    out.append("")

sql = "\n".join(out)
with open(os.path.join(ROOT, 'supabase', 'migrate.sql'), 'w', encoding='utf-8') as f:
    f.write(sql)

print("Wrote supabase/migrate.sql:", len(sql), "bytes across", len(data), "tables")
