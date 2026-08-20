import { useMemo, useState } from 'react'
import { Send, Users, User } from 'lucide-react'
import { repo, allContacts, messagesFor, sendMessage } from '../data/repository'
import { useApp } from '../store/app'
import { PageHeader, Card, EmptyState } from '../components/ui'

export default function Messages() {
  const user = useApp(s => s.user)!
  const [thread, setThread] = useState<'group' | string>('group')
  const [text, setText] = useState('')
  const [tick, setTick] = useState(0)

  // Contacts you can DM: MD ↔ partners/workers; partner/worker ↔ MD.
  const contacts = useMemo(() => {
    const all = allContacts().filter(c => c.phone !== user.phone)
    return user.role === 'md' ? all.filter(c => c.role !== 'md') : all.filter(c => c.role === 'md')
  }, [user.phone, user.role])

  const all = useMemo(() => messagesFor(user.phone), [user.phone, tick])
  const shown = useMemo(() => {
    if (thread === 'group') return all.filter(m => m.Scope === 'group')
    return all.filter(m => m.Scope === 'direct' && (m.From_Phone === thread || m.To_Phone === thread))
  }, [all, thread])

  const contact = contacts.find(c => c.phone === thread)

  async function send() {
    const body = text.trim()
    if (!body) return
    if (thread === 'group') {
      await sendMessage({ Scope: 'group', From_Phone: user.phone, From_Name: user.name, Finance_Name: user.finance, Body: body })
    } else if (contact) {
      await sendMessage({ Scope: 'direct', From_Phone: user.phone, From_Name: user.name, To_Phone: contact.phone, To_Name: contact.name, Finance_Name: user.finance, Body: body })
    }
    setText(''); setTick(t => t + 1)
  }

  return (
    <div>
      <PageHeader title="Messages" subtitle="Group broadcast, or a direct message." />
      <div className="grid gap-4 lg:grid-cols-[16rem_1fr]">
        {/* Threads */}
        <Card className="!p-2 h-max">
          <button onClick={() => setThread('group')}
            className={`flex w-full items-center gap-2 rounded-lg px-3 py-2 text-sm ${thread === 'group' ? 'bg-brand-600 text-white' : 'text-slate-300 hover:bg-slate-800/60'}`}>
            <Users size={16} /> Group
          </button>
          <p className="mt-2 px-3 text-[10px] font-semibold uppercase tracking-wider text-slate-500">Direct</p>
          {contacts.length === 0 && <p className="px-3 py-2 text-xs text-slate-500">No contacts.</p>}
          {contacts.map(c => (
            <button key={c.phone} onClick={() => setThread(c.phone)}
              className={`flex w-full items-center gap-2 rounded-lg px-3 py-2 text-sm ${thread === c.phone ? 'bg-brand-600 text-white' : 'text-slate-300 hover:bg-slate-800/60'}`}>
              <User size={16} /> <span className="truncate">{c.name}</span>
              <span className="ml-auto text-[10px] uppercase text-slate-500">{c.role}</span>
            </button>
          ))}
        </Card>

        {/* Conversation */}
        <Card className="flex h-[60vh] flex-col !p-0">
          <div className="border-b border-slate-800 px-4 py-2.5 text-sm font-semibold text-white">
            {thread === 'group' ? 'Group' : contact?.name ?? 'Direct'}
          </div>
          <div className="flex-1 space-y-2 overflow-y-auto p-4">
            {shown.length === 0 ? <EmptyState title="No messages yet" hint="Say hello 👋" /> : shown.map(m => {
              const mine = m.From_Phone === user.phone
              return (
                <div key={m.id} className={`flex ${mine ? 'justify-end' : 'justify-start'}`}>
                  <div className={`max-w-[80%] rounded-2xl px-3 py-2 text-sm ${mine ? 'bg-brand-600 text-white' : 'bg-slate-800 text-slate-100'}`}>
                    {!mine && <p className="mb-0.5 text-[11px] font-semibold text-brand-300">{m.From_Name}</p>}
                    <p className="whitespace-pre-wrap">{m.Body}</p>
                    <p className={`mt-0.5 text-[10px] ${mine ? 'text-white/60' : 'text-slate-500'}`}>{new Date(m.Date).toLocaleString('en-IN')}</p>
                  </div>
                </div>
              )
            })}
          </div>
          <div className="flex items-center gap-2 border-t border-slate-800 p-3">
            <input
              className="input" placeholder={`Message ${thread === 'group' ? 'the group' : contact?.name ?? ''}…`}
              value={text} onChange={e => setText(e.target.value)}
              onKeyDown={e => { if (e.key === 'Enter') send() }}
            />
            <button className="btn-primary" onClick={send} disabled={!text.trim()}><Send size={16} /></button>
          </div>
        </Card>
      </div>
      <p className="mt-3 text-xs text-slate-500">Recipients get a bell notification. Finances: {repo.finances().length}.</p>
    </div>
  )
}
