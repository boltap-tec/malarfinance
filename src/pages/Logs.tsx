import { useState } from 'react'
import { History, RotateCcw } from 'lucide-react'
import { repo, restoreFromLog } from '../data/repository'
import { useApp } from '../store/app'
import { PageHeader, Card, Badge, Th, Td, EmptyState } from '../components/ui'

const actionTone: Record<string, 'green' | 'amber' | 'red' | 'blue' | 'slate'> = {
  create: 'green', update: 'amber', delete: 'red', revoke: 'red', restore: 'blue',
}

export default function Logs() {
  const role = useApp(s => s.user?.role)
  const [tick, setTick] = useState(0)
  const rows = repo.logs()

  if (role !== 'md') return <EmptyState title="Only the MD can view the log" />

  async function restore(id: string) { await restoreFromLog(id); setTick(t => t + 1) }

  return (
    <div>
      <PageHeader title="Activity log" subtitle="Every create, edit, delete and revoke — deletes can be restored." />
      <div key={tick}>
        {rows.length === 0 ? <EmptyState title="No activity yet" /> : (
          <Card className="!p-0 overflow-hidden">
            <div className="overflow-x-auto">
              <table className="w-full">
                <thead className="border-b border-slate-800 bg-slate-900/60">
                  <tr><Th>When</Th><Th>User</Th><Th>Action</Th><Th>Entity</Th><Th>Details</Th><Th>Restore</Th></tr>
                </thead>
                <tbody className="divide-y divide-slate-800">
                  {rows.map(l => {
                    const restorable = (l.Action === 'delete' || l.Action === 'revoke') && !l.Restored
                    return (
                      <tr key={l.id} className="hover:bg-slate-800/40">
                        <Td className="whitespace-nowrap text-xs text-slate-400">{new Date(l.Date).toLocaleString('en-IN')}</Td>
                        <Td className="text-slate-300">{l.User}</Td>
                        <Td><Badge tone={actionTone[l.Action] ?? 'slate'}>{l.Action}</Badge></Td>
                        <Td className="text-slate-400">{l.Entity}</Td>
                        <Td className="text-slate-300">{l.Entity_Label ?? '—'}</Td>
                        <Td>
                          {restorable
                            ? <button className="btn-ghost !px-2.5 !py-1 text-xs" onClick={() => restore(l.id)}><RotateCcw size={13} /> Restore</button>
                            : l.Restored ? <span className="text-xs text-emerald-400">restored</span> : <span className="text-xs text-slate-600">—</span>}
                        </Td>
                      </tr>
                    )
                  })}
                </tbody>
              </table>
            </div>
          </Card>
        )}
      </div>
      <p className="mt-3 flex items-center gap-1.5 text-xs text-slate-500"><History size={12} /> Restoring re-inserts the removed rows and records a restore entry.</p>
    </div>
  )
}
