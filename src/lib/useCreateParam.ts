import { useState, useEffect } from 'react'
import { useSearchParams } from 'react-router-dom'
import { useApp, canEdit } from '../store/app'

// Lets a page open its "New …" form directly from a link like /loans?new=1
// (used by the command palette and dashboard quick-actions). Clearing the flag
// removes the query param so a refresh doesn't reopen the form.
// View-only roles (partners) can never open a create form, even by URL.
export function useCreateParam(): [boolean, (v: boolean) => void] {
  const [params, setParams] = useSearchParams()
  const role = useApp(s => s.user?.role)
  const allowed = canEdit(role)
  const [open, setOpen] = useState(allowed && params.get('new') === '1')

  useEffect(() => {
    if (allowed && params.get('new') === '1') setOpen(true)
  }, [params, allowed])

  const set = (v: boolean) => {
    setOpen(v)
    if (!v && params.get('new') === '1') {
      params.delete('new')
      setParams(params, { replace: true })
    }
  }
  return [open, set]
}
