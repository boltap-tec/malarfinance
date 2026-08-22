"""Build the unified Hand_Exchange table from the existing Given / Borrowed rows
and fold it into src/data/seed.json. Personal money tracker — never touches any
finance table.

Each entry is a money movement with a Direction:
  out = money left your hand   in = money came to your hand
Type is a friendly label: Give / Get / Borrow / Return.

Net "they owe you" per person = sum(out) − sum(in):
  Give (+out)  they owe you more
  Get  (−in)   they returned / you received
  Borrow(−in)  you owe them
  Return(+out) you repaid them
"""
import io, json, os

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SEED = os.path.join(ROOT, 'src', 'data', 'seed.json')

with io.open(SEED, encoding='utf-8') as f:
    data = json.load(f)


def num(v):
    try: return float(v)
    except (TypeError, ValueError): return 0.0


entries = []

# Given: you handed money out (they owe you). Settled ones got paid back.
for g in data.get('Given', []):
    amt = num(g.get('Amount'))
    base = {
        'ID': g.get('ID'), 'Date': g.get('Date'), 'Person': g.get('Name'), 'Person_Phone': None,
        'Amount': amt, 'Direction': 'out', 'Type': 'Give',
        'Mode': g.get('Mode'), 'Note': g.get('Description'), 'Remarks': g.get('Remarks'),
    }
    entries.append(base)
    if str(g.get('Status', '')).lower().startswith('fully'):   # Fully_Got -> money came back
        entries.append({**base, 'ID': f"{g.get('ID')}-got", 'Direction': 'in', 'Type': 'Get',
                        'Note': f"Received back — {g.get('Description') or ''}".strip(' —')})

# Borrowed: you took money in (you owe them). Settled ones were returned.
for b in data.get('Borrowed', []):
    amt = num(b.get('Amount'))
    base = {
        'ID': b.get('ID'), 'Date': b.get('Date'), 'Person': b.get('Name'), 'Person_Phone': None,
        'Amount': amt, 'Direction': 'in', 'Type': 'Borrow',
        'Mode': b.get('Mode'), 'Note': b.get('Description'), 'Remarks': b.get('Remarks'),
    }
    entries.append(base)
    if str(b.get('Status', '')).lower().startswith('fully'):   # Fully_Given -> you returned it
        entries.append({**base, 'ID': f"{b.get('ID')}-ret", 'Direction': 'out', 'Type': 'Return',
                        'Note': f"Returned — {b.get('Description') or ''}".strip(' —')})

# Splice in after 'Borrowed', keeping key order; keep Given/Borrowed as raw backup.
out = {}
for k, v in data.items():
    out[k] = v
    if k == 'Borrowed':
        out['Hand_Exchange'] = entries
if 'Hand_Exchange' not in out:
    out['Hand_Exchange'] = entries

with io.open(SEED, 'w', encoding='utf-8') as f:
    json.dump(out, f, indent=0, ensure_ascii=False)

people = sorted({e['Person'] for e in entries if e['Person']})
print(f'Hand_Exchange rows: {len(entries)} across {len(people)} people')
