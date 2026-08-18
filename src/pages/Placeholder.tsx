import { Construction } from 'lucide-react'
import { PageHeader } from '../components/ui'

export default function Placeholder({ title, note }: { title: string; note?: string }) {
  return (
    <div>
      <PageHeader title={title} />
      <div className="card grid place-items-center gap-3 p-16 text-center">
        <div className="grid h-14 w-14 place-items-center rounded-2xl bg-brand-500/15 text-brand-300"><Construction size={26} /></div>
        <p className="font-semibold text-slate-200">Module coming next</p>
        {note && <p className="max-w-md text-sm text-slate-500">{note}</p>}
      </div>
    </div>
  )
}
