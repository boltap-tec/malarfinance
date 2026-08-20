import { useState, useEffect } from 'react'
import { useSearchParams } from 'react-router-dom'

// Lets a page open its "New …" form directly from a link like /loans?new=1
// (used by the command palette and dashboard quick-actions). Clearing the flag
// removes the query param so a refresh doesn't reopen the form.
export function useCreateParam(): [boolean, (v: boolean) => void] {
  const [params, setParams] = useSearchParams()
  const [open, setOpen] = useState(params.get('new') === '1')

  useEffect(() => {
    if (params.get('new') === '1') setOpen(true)
  }, [params])

  const set = (v: boolean) => {
    setOpen(v)
    if (!v && params.get('new') === '1') {
      params.delete('new')
      setParams(params, { replace: true })
    }
  }
  return [open, set]
}
